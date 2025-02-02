module Church where
{-
    The Church module contains definitions for Church-encoded boolean values and logical operations.
-}

import LambdaCalc

-- Church boolean values

churchTrue :: Expr
churchTrue = Lam "x" (Lam "y" (Var "x"))

churchFalse :: Expr
churchFalse = Lam "x" (Lam "y" (Var "y"))

-- Church logical operations on booleans

-- And: returns the second argument if the first argument is true, otherwise false
churchAnd :: Expr -> Expr -> Expr
churchAnd p q = App (App p q) churchFalse

-- Or: returns the first argument if it is true, otherwise returns the second argument
churchOr :: Expr -> Expr -> Expr
churchOr p q = App (App p churchTrue) q

-- Not: returns the opposite of the given boolean value
churchNot :: Expr -> Expr
churchNot p = App (App p churchFalse) churchTrue

-- Church conditionals

-- If: a conditional expression that evaluates to one of two branches based on the condition
churchIf :: Expr -> Expr -> Expr -> Expr
churchIf cond tBranch fBranch = App (App cond tBranch) fBranch

-- Church numbers

-- Zero: represents the number zero
churchZero :: Expr
churchZero = Lam "f" (Lam "x" (Var "x"))

-- Successor: returns the next number after the given number
churchSucc :: Expr -> Expr
churchSucc n = Lam "f" (Lam "x" (App (Var "f") (App (App n (Var "f")) (Var "x"))))

-- Predecessor: returns the previous number before the given number
churchPred :: Expr -> Expr
churchPred n = Lam "f" (Lam "x" (App (App (App n (Lam "g" (Lam "h" (App (Var "h") (App (Var "g") (Var "f")))))) (Lam "u" (Var "x"))) (Lam "u" (Var "u"))))

-- Addition: adds two numbers together
churchAdd :: Expr -> Expr -> Expr
churchAdd m n = Lam "f" (Lam "x" (App (App m (Var "f")) (App (App n (Var "f")) (Var "x"))))

-- Multiplication: multiplies two numbers together
churchMult :: Expr -> Expr -> Expr
churchMult m n = Lam "f" (App m (App n (Var "f")))

-- Exponentiation: raises the first number to the power of the second number
churchExp :: Expr -> Expr -> Expr
churchExp m n = App n m