module Eval where
{-
    The Eval module contains functions for evaluating lambda calculus expressions.
-}

import LambdaCalc

-- Substitute variable `x` with expression `val` in `expr`
substitute :: String -> Expr -> Expr -> Expr
substitute x val (Var y) 
    | x == y    = val
    | otherwise = Var y
substitute x val (Lam y body)
    | x == y    = Lam y body
    | otherwise = Lam y (substitute x val body)
substitute x val (App e1 e2) = App (substitute x val e1) (substitute x val e2)

-- Perform beta reduction (one step)
betaReduceStep :: Expr -> Expr
betaReduceStep (App (Lam x body) arg) = substitute x arg body  -- Apply function
betaReduceStep (App e1 e2) = App (betaReduceStep e1) (betaReduceStep e2)
betaReduceStep (Lam x e)   = Lam x (betaReduceStep e)
betaReduceStep expr        = expr  -- Variables stay the same

betaReduce :: Expr -> Expr
betaReduce expr =
    let reducedExpr = betaReduceStep expr
    in if reducedExpr == expr
       then expr
       else betaReduce reducedExpr