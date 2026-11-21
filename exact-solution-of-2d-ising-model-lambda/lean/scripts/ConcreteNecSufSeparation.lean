/-
具体版と必要十分版の分離の検査が読む、依存の書き出し。

`lake build` の後に `lake env lean scripts/ConcreteNecSufSeparation.lean` で実行する
（`scripts/check-concrete-necsuf-separation.sh` が呼ぶ）。ライブラリの一部ではないので、入口
`Ising2DLambda.lean` からは import しない。

本プロジェクトの定数を三つに分ける。

- 必要十分版: モジュール名に `NecSuf` の成分を持つ、または名前に `NecSuf` の成分を持つ。
- 導出: モジュール名の最後の成分が `FromNecSuf` で終わる、または名前が `_from_necSuf` で終わる。
- 具体版: それ以外。

`.eq_1`・`._proof_1`・`.match_1` のような自動生成の定数は、親の宣言の側に数える
（等式の補題は最初に使ったモジュールで作られるので、モジュール名では分けられない）。

書き出すもの（タブ区切り、一行に一件）。

- `DEP  <使う側の分類>  <使う側の宣言>  <使われる側の分類>  <使われる側の宣言>`:
  具体版が必要十分版か導出を、または必要十分版が具体版か導出を、主張か本体で直接使うもの。
- `IMPORT  <取り込む側の分類>  <取り込む側のモジュール>  <取り込まれる側の分類>  <取り込まれる側のモジュール>`:
  同じ向きのモジュールの import。
-/
import Ising2DLambda
open Lean

/-- 自動生成の定数を、それを生んだ宣言へ戻す。 -/
partial def rootDecl (env : Environment) (n : Name) : Name :=
  match n with
  | .str p s =>
    let generated := s.startsWith "_" || s.startsWith "eq_" || s.startsWith "match_" ||
      s.startsWith "proof_" || s == "eq_def" || s == "injEq" || s == "inj" ||
      s == "casesOn" || s == "recOn" || s == "rec" || s == "noConfusion" ||
      s == "noConfusionType" || s == "ctorIdx" || s == "below" || s == "brecOn"
    if generated && (env.find? p).isSome then rootDecl env p else n
  | _ => n

def userName (n : Name) : Name := (privateToUserName? n).getD n

def hasComponent (n : Name) (c : String) : Bool :=
  n.components.any fun x => x.toString == c

def classifyModule (m : Name) : String :=
  if hasComponent m "NecSuf" then "necsuf"
  else if m.getString!.endsWith "FromNecSuf" then "derivation"
  else "concrete"

/-- モジュールの番号ごとの分類。本プロジェクトのモジュールでなければ `none`。 -/
def moduleClasses (env : Environment) : Array (Option String) :=
  env.header.moduleNames.map fun m =>
    if (`Ising2DLambda).isPrefixOf m then some (classifyModule m) else none

/-- 定数の分類。mathlib の定数はモジュールの番号だけで先に外す（ここが速さを決める）。 -/
def classify (env : Environment) (mods : Array (Option String)) (n : Name) : Option String := do
  let idx ← env.getModuleIdxFor? n
  let _ ← mods[idx.toNat]!
  let r := rootDecl env n
  let ridx ← env.getModuleIdxFor? r
  let cm ← mods[ridx.toNat]!
  let u := userName r
  if hasComponent u "NecSuf" then return "necsuf"
  if u.toString.endsWith "_from_necSuf" then return "derivation"
  return cm

def crosses (user used : String) : Bool :=
  (user == "concrete" && used != "concrete") || (user == "necsuf" && used != "necsuf")

#eval show CoreM Unit from do
  let env ← getEnv
  let mods := moduleClasses env
  let out ← IO.FS.Handle.mk (System.FilePath.mk ".lake/concrete-necsuf-separation.tsv") .write
  let mut seen : Std.HashSet (Name × Name) := {}
  for (n, ci) in env.constants.toList do
    let some cu := classify env mods n | continue
    if cu == "derivation" then continue
    let used : Array Name := ci.type.getUsedConstants ++ match ci with
      | .inductInfo i => i.ctors.toArray
      | _ => match ci.value? (allowOpaque := true) with
        | some v => v.getUsedConstants
        | none => #[]
    let user := userName (rootDecl env n)
    for d in used do
      let some cd := classify env mods d | continue
      if crosses cu cd then
        let target := userName (rootDecl env d)
        if !seen.contains (user, target) then
          seen := seen.insert (user, target)
          out.putStrLn s!"DEP\t{cu}\t{user}\t{cd}\t{target}"
  let names := env.header.moduleNames
  for i in [0:names.size] do
    let m := names[i]!
    unless (`Ising2DLambda).isPrefixOf m && m != `Ising2DLambda do continue
    let cm := classifyModule m
    if cm == "derivation" then continue
    for imp in env.header.moduleData[i]!.imports do
      let t := imp.module
      unless (`Ising2DLambda).isPrefixOf t do continue
      let ct := classifyModule t
      if crosses cm ct then
        out.putStrLn s!"IMPORT\t{cm}\t{m}\t{ct}\t{t}"
