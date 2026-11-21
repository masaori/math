/-
具体版の宣言が、ただ一つの最終定理の依存に入っているかの検査が読む、依存の書き出し。
`check.sh` が `lake env lean` で実行する。ライブラリの一部ではない。

最終定理は `Ising2D.onsager_exact_solution_end_to_end`（`scripts/check-end-to-end.sh` が型を固定する定理）である。
その主張と証明から、Ising2D の定数の主張・本体・帰納型の構成子を推移的にたどり、届いた定数を集める。
mathlib の定数は Ising2D の定数を使わないので、たどるのは Ising2D のモジュールの定数だけでよい。

数える宣言は具体版のものだけである。分類は分離の検査
（リポジトリ直下 `scripts/lean-concrete-necsuf-separation/Separation.lean.in`）と同じで、必要十分版
（モジュール名か宣言の名前に `NecSuf` の成分を持つ）と導出（モジュール名の最後の成分が `FromNecSuf` で終わる、
または名前の最後の成分に `necSuf` を含む）を除く。加えて、本文から退避した経路の置き場
（モジュール名に `RoutesNotAdopted` の成分を持つ）を除く。

`.eq_1`・`._proof_1`・`.match_1` のような自動生成の定数と、構成子・射影は、それを生んだ宣言の側に数える。
親の宣言かそれから生まれた定数のどれかに届けば、その宣言は届いたとみなす。強制のインスタンスは数えない（`isCoercionInstance`）。

たどる道は、数えないモジュール（必要十分版・導出・RoutesNotAdopted）の定数も通る。導出を経てしか使われない具体版も
届いたと数えるが、分離の検査の台帳が空になれば具体版から導出・必要十分版への依存は無くなるので、両方の台帳が空なら
「具体版の宣言が全て、具体版だけを通って最終定理に届く」が成り立つ。

書き出すもの（タブ区切り、一行に一件）: `UNCONNECTED  <宣言>  <モジュール>`、
数えた宣言のどれも届かないモジュールの `MODULE_WITHOUT_CONNECTED  <モジュール>`、最後に `TOTAL  <数えた具体版の宣言の数>`。
-/
import Ising2D
open Lean

def userName (n : Name) : Name := (privateToUserName? n).getD n

/-- 親の名前を環境で引く。private の宣言から生まれた match の式などは、親が private の接頭辞付きの名前では
見つからず公開名で在ることがあるので、両方を引く。 -/
def findParent (env : Environment) (p : Name) : Option Name :=
  if env.contains p then some p
  else match privateToUserName? p with
    | some u => if env.contains u then some u else none
    | none => none

/-- 数字と `_` だけからなり、数字で始まり数字で終わるか（`1`・`1_1`）。 -/
def isDigits (s : String) : Bool :=
  !s.isEmpty && s.all (fun c => c.isDigit || c == '_') && s.front.isDigit && s.back.isDigit

/-- `eq_1`・`match_2`・`match_1_1`・`proof_3` のような番号付きの自動生成の名前か。 -/
def numberedGenerated (s : String) : Bool :=
  ["eq_", "match_", "proof_"].any fun pre => s.startsWith pre && isDigits (s.drop pre.length).toString

/-- 自動生成の定数・構成子・射影を、それを生んだ宣言へ戻す。
ユーザーの宣言を畳まないよう、名前の形だけでなく親の種類も見る。帰納型の付属物（`rec` など）は親が帰納型のとき、
`inj`・`injEq`・`sizeOf_spec`・`noConfusion` は親が構成子のときだけ畳む。`ext`・`ext_iff` は手で書いた定理と見分けられないので畳まない。 -/
partial def rootDecl (env : Environment) (n : Name) : Name :=
  match env.find? n with
  | some (.ctorInfo c) => rootDecl env c.induct
  | _ =>
    if let some info := env.getProjectionFnInfo? n then
      match env.find? info.ctorName with
      | some (.ctorInfo c) => rootDecl env c.induct
      | _ => n
    else
      match n with
      | .str p s =>
        match findParent env p with
        | none => n
        | some q =>
          let parentIsInductive := match env.find? q with
            | some (.inductInfo _) => true
            | _ => false
          let parentIsCtor := match env.find? q with
            | some (.ctorInfo _) => true
            | _ => false
          let generated := s.startsWith "_" || numberedGenerated s ||
            s == "eq_def" || s == "eq_unfold" || s == "splitter" || s == "congr_simp" ||
            (parentIsCtor && (s == "inj" || s == "injEq" || s == "sizeOf_spec" || s == "noConfusion")) ||
            (parentIsInductive && ["casesOn", "recOn", "rec", "noConfusion", "noConfusionType",
              "ctorIdx", "below", "brecOn", "ibelow", "binductionOn",
              "ofNat", "toCtorIdx", "ctorElim", "ctorElimType", "ofNat_ctorIdx"].contains s)
          if generated then rootDecl env q else n
      | _ => n

/-- 型の結論が `Coe` の類の型クラスであるインスタンスか。強制はエラボレーションで中身へ展開され、使った側の項に
インスタンスの名前が残らないので、依存をたどっても届かない。数える宣言から外す。 -/
def isCoercionInstance (ci : ConstantInfo) : Bool :=
  match ci.type.getForallBody.getAppFn.constName? with
  | some c => [``Coe, ``CoeOut, ``CoeTail, ``CoeHead, ``CoeHTCT, ``CoeTC, ``CoeOTC, ``CoeHTC,
      ``CoeSort, ``CoeFun, ``CoeDep, ``CoeT].contains c
  | none => false

def hasComponent (n : Name) (c : String) : Bool :=
  n.components.any fun x => x.toString == c

def isIsingModule (m : Name) : Bool := (`Ising2D).isPrefixOf m

/-- 具体版で、退避した経路の置き場でないモジュールか。 -/
def countedModule (m : Name) : Bool :=
  isIsingModule m && !hasComponent m "NecSuf" && !m.getString!.endsWith "FromNecSuf" &&
    !hasComponent m "RoutesNotAdopted"

/-- 宣言の名前が必要十分版か導出のものか。 -/
def necSufOrDerivationName (u : Name) : Bool :=
  hasComponent u "NecSuf" ||
    match u with
    | .str _ last => (last.toLower.splitOn "necsuf").length > 1
    | _ => false

def usedConstants (ci : ConstantInfo) : Array Name :=
  ci.type.getUsedConstants ++ match ci with
    | .inductInfo i => i.ctors.toArray
    | _ => match ci.value? (allowOpaque := true) with
      | some v => v.getUsedConstants
      | none => #[]

#eval show CoreM Unit from do
  let env ← getEnv
  let finalTheorem := `Ising2D.onsager_exact_solution_end_to_end
  unless (env.find? finalTheorem).isSome do
    throwError "最終定理 {finalTheorem} が無い"
  -- モジュールの番号ごとの判定を先に作る（定数ごとにモジュール名を引くと遅い）。
  let moduleNames := env.header.moduleNames
  let isingModules : Array Bool := moduleNames.map isIsingModule
  let countedModules : Array Bool := moduleNames.map countedModule
  let inIsing (n : Name) : Bool :=
    match env.getModuleIdxFor? n with
    | some idx => isingModules[idx.toNat]!
    | none => false
  -- 最終定理から Ising2D の定数を推移的にたどる。
  let mut reached : Std.HashSet Name := {}
  let mut stack : Array Name := #[finalTheorem]
  while h : stack.size > 0 do
    let n := stack[stack.size - 1]
    stack := stack.pop
    if reached.contains n then continue
    reached := reached.insert n
    let some ci := env.find? n | continue
    for d in usedConstants ci do
      if inIsing d && !reached.contains d then
        stack := stack.push d
  let reachedRoots : Std.HashSet Name :=
    reached.fold (init := {}) fun s n => s.insert (rootDecl env n)
  -- 数える具体版の宣言（親の宣言だけ）を集め、届かなかったものを書き出す。
  let mut counted : Std.HashMap Name Name := {}
  for (n, ci) in env.constants.toList do
    unless inIsing n do continue
    if isCoercionInstance ci then continue
    let r := rootDecl env n
    let some ridx := env.getModuleIdxFor? r | continue
    unless countedModules[ridx.toNat]! do continue
    let m := moduleNames[ridx.toNat]!
    if necSufOrDerivationName (userName r) then continue
    counted := counted.insert r m
  let out ← IO.FS.Handle.mk (System.FilePath.mk ".lake/connection-to-final-theorem/unconnected.tsv") .write
  let mut modulesWithReached : Std.HashSet Name := {}
  let mut modules : Std.HashSet Name := {}
  for (r, m) in counted.toList do
    modules := modules.insert m
    if reachedRoots.contains r then
      modulesWithReached := modulesWithReached.insert m
    else
      out.putStrLn s!"UNCONNECTED\t{userName r}\t{m}"
  for m in modules.toList do
    unless modulesWithReached.contains m do
      out.putStrLn s!"MODULE_WITHOUT_CONNECTED\t{m}"
  out.putStrLn s!"TOTAL\t{counted.size}"
