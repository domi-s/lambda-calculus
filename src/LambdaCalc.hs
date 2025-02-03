module LambdaCalc where
{-
    The LambdaCalc module contains definitions for lambda calculus expressions and operations.

    Variables are represented as strings, lambda abstractions as `Lam x e`, and function applications as `App e1 e2`.
-}

data Expr
    = Var String
    | Lam String Expr
    | App Expr Expr
    deriving (Eq)

-- Pretty-printing
instance Show Expr where
    show (Lam "x" (Lam "y" (Var "x"))) = "True"
    show (Lam "x" (Lam "y" (Var "y"))) = "False"
    show (Lam "x" (Lam "y" (App (App (Var "x") (Var "y")) (Var "y")))) = "And"
    show (Lam "x" (Lam "y" (App (App (Var "x") (Var "x")) (Var "y")))) = "Or"
    show (Lam "x" (App (Var "x") (Var "y"))) = "Not"
    show (Lam "x" (Lam "y" (App (App (Var "x") (Var "y")) (Var "y")))) = "If"
    show (Var x) = x
    show (Lam x e) = "λ" ++ x ++ ". " ++ show e
    show (App e1 e2) = "(" ++ show e1 ++ " " ++ show e2 ++ ")"