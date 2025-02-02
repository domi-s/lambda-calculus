module Main where

-- import REPL

-- main :: IO ()
-- main = repl

import LambdaCalc
import Church
import Eval

main :: IO()
main = do
    -- Church booleans
    let trueValue = churchTrue
    let falseValue = churchFalse

    -- Testing AND, OR, NOT
    let trueAndFalse = churchAnd churchTrue churchFalse
    let trueOrFalse = churchOr churchTrue churchFalse
    let notTrue = churchNot churchTrue
    let ifTest = churchIf churchTrue (Var "true") (Var "false")

    -- Output results
    putStrLn $ "True AND False: " ++ show trueAndFalse
    putStrLn $ "True OR False: " ++ show trueOrFalse
    putStrLn $ "Not True: " ++ show notTrue
    putStrLn $ "If True then 'true' else 'false': " ++ show ifTest

    putStrLn "Beta reduction tests:"

    putStrLn $ "True AND False: " ++ show (betaReduce trueAndFalse)
    putStrLn $ "True OR False: " ++ show (betaReduce trueOrFalse)
    putStrLn $ "Not True: " ++ show (betaReduce notTrue)
    putStrLn $ "If True then 'true' else 'false': " ++ show (betaReduce ifTest)