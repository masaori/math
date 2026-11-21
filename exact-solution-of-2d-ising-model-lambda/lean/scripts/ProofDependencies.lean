/-
論文との一対一の突き合わせに使う、具体版の定数の直接依存。
出力は「使う宣言・主張か本体か・使われる宣言」の TSV。
補助補題を越える追跡と本文との照合は別の段階で行う。
-/
import Ising2DLambda
open Lean

def isProjectConstant (env : Environment) (n : Name) : Bool :=
  match env.getModuleIdxFor? n with
  | none => false
  | some i => (`Ising2DLambda).isPrefixOf env.header.moduleNames[i.toNat]!

def isConcreteConstant (env : Environment) (n : Name) : Bool :=
  if !isProjectConstant env n then false
  else
    let name := n.toString
    (name.toLower.splitOn "necsuf").length == 1

#eval show CoreM Unit from do
  let env ← getEnv
  let out ← IO.FS.Handle.mk
    (System.FilePath.mk ".lake/one-to-one/direct-dependencies.unsorted.tsv") .write
  for (n, ci) in env.constants.toList do
    unless isConcreteConstant env n do continue
    let kind := match ci with
      | .thmInfo _ => "theorem"
      | _ => "other"
    out.putStrLn s!"{n}\tdecl\t{kind}"
    for d in ci.type.getUsedConstants do
      if isProjectConstant env d && n != d then
        out.putStrLn s!"{n}\ttype\t{d}"
    if let some value := ci.value? (allowOpaque := true) then
      for d in value.getUsedConstants do
        if isProjectConstant env d && n != d then
          out.putStrLn s!"{n}\tvalue\t{d}"
