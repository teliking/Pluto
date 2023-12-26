#include "llvm/Transforms/Obfuscation/IndirectCall.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Transforms/Obfuscation/MBAObfuscation.h"
#include "llvm/Transforms/Utils/LowerSwitch.h"
#include <algorithm>
#include <map>
#include <random>
#include <vector>

namespace Pluto {

PreservedAnalyses Pluto::IndirectCall::run(Module &M, ModuleAnalysisManager &AM) {
    LLVMContext &context = M.getContext();
    IRBuilder<> builder(context);

    std::vector<Function *> functions;
    for (Function &F : M) {
        if (F.size() && !F.hasLinkOnceLinkage()) {
            functions.push_back(&F);
        }
    }

    std::random_device rd;
    std::default_random_engine rng(rd());
    std::shuffle(functions.begin(), functions.end(), rng);

    std::vector<Constant *> funcAddrs;
    for (Function *F : functions) {
        funcAddrs.push_back(BlockAddress::get(&F->getEntryBlock()));
    }

    // Save function addresses to global variable
    ArrayRef<Constant *> funcAddrsRef(funcAddrs);
    Constant *funcAddrsArray =
        ConstantArray::get(ArrayType::get(Type::getInt64Ty(context), funcAddrs.size()), funcAddrsRef);
    ArrayType *functionTableType = ArrayType::get(Type::getInt64Ty(context), funcAddrs.size());
    GlobalVariable *functionTable =
        new GlobalVariable(M, functionTableType, false, GlobalVariable::PrivateLinkage, funcAddrsArray);

    for (Function &F : M) {
        // if(!F.size()) continue;
        // std::vector<BasicBlock *> normalBlocks;
        // std::queue<BasicBlock *> queue;
        // queue.push(&F.getEntryBlock());
        // while (queue.size()) {
        //     BasicBlock *BB = queue.front();
        //     queue.pop();
        //     if (find(normalBlocks.begin(), normalBlocks.end(), BB) != normalBlocks.end()) {
        //         continue;
        //     }
        //     normalBlocks.push_back(BB);
        //     if (InvokeInst *invoke = dyn_cast_or_null<InvokeInst>(BB->getTerminator())) {
        //         queue.push(invoke->getNormalDest());
        //     } else {
        //         for (size_t i = 0; i < BB->getTerminator()->getNumSuccessors(); i++) {
        //             BasicBlock *successor = BB->getTerminator()->getSuccessor(i);
        //             queue.push(successor);
        //         }
        //     }
        // }

        for (BasicBlock &BB : F) {
            for (Instruction &I : BB) {
                if (CallInst *CI = dyn_cast<CallInst>(&I)) {
                    Function *callee = CI->getCalledFunction();
                    if (callee && callee->size() && !callee->hasLinkOnceLinkage()) {
                        // Find the correct index of current callee
                        int i = 0;
                        for (Function *_F : functions) {
                            if (_F->getName() == callee->getName()) {
                                break;
                            }
                            i++;
                        }
                        builder.SetInsertPoint(&F.getEntryBlock().front());

                        // Make index able to be obfuscated by MBAObfuscation
                        AllocaInst *indexPtr = builder.CreateAlloca(Type::getInt32Ty(context));
                        builder.CreateStore(ConstantInt::get(Type::getInt32Ty(context), 0), indexPtr);
                        Value *index = builder.CreateAdd(builder.CreateLoad(indexPtr->getAllocatedType(), indexPtr),
                                                         ConstantInt::get(Type::getInt32Ty(context), i));

                        // Replace the original called operand
                        auto GEP = builder.CreateGEP(functionTableType, functionTable,
                                                     {ConstantInt::get(Type::getInt32Ty(context), 0), index});
                        CI->setCalledOperand(builder.CreateLoad(functionTableType->getElementType(), GEP));
                    }
                }
            }
        }
    }

    return PreservedAnalyses::all();
}

}; // namespace Pluto