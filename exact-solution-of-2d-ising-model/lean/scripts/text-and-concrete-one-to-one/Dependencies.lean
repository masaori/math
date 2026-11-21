/-
本文のブロックと具体版の宣言の一対一の検査（`check.sh`）が読む、具体版の宣言の docstring と証明の依存の書き出し。
`check.sh` が `lake env lean` で実行する。ライブラリの一部ではない。突き合わせは `compare.ts` が行う。

書き出すのは Ising2D のモジュールの宣言（自動生成の定数・構成子・射影は、それを生んだ宣言へ戻す。戻し方は
繋がりの検査 `scripts/connection-to-final-theorem/Connection.lean` と同じ）について、次の二種類の行である（タブ区切り）。
- `DECL  <宣言>  <モジュール>  <種類>  <具体版か>  <docstring の先頭の太字>`
  種類は定理なら `theorem`、それ以外は `other`。具体版かは、繋がりの検査と同じ分類（必要十分版・導出・RoutesNotAdopted を除く）で
  具体版なら `1`、そうでなければ `0`。docstring の先頭の太字は、docstring が `**` で始まるときの最初の `**…**` の中身
  （タブと改行は空白に替える）で、無ければ空。
- `USES  <宣言>  <使う宣言>`
  定理の証明（本体）が直接使う Ising2D の宣言。定理でない宣言の本体は見ない（本文の証明が引く主張と比べるのは証明だからである）。
  自動生成の補助（`._proof_1`・`.match_1` など）の本体が使うものも、それを生んだ宣言が使うものに数える。
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

def hasComponent (n : Name) (c : String) : Bool :=
  n.components.any fun x => x.toString == c

def isIsingModule (m : Name) : Bool := (`Ising2D).isPrefixOf m

/-- 具体版で、退避した経路の置き場でないモジュールか（繋がりの検査と同じ）。 -/
def countedModule (m : Name) : Bool :=
  isIsingModule m && !hasComponent m "NecSuf" && !m.getString!.endsWith "FromNecSuf" &&
    !hasComponent m "RoutesNotAdopted"

/-- 宣言の名前が必要十分版か導出のものか（繋がりの検査と同じ）。 -/
def necSufOrDerivationName (u : Name) : Bool :=
  hasComponent u "NecSuf" ||
    match u with
    | .str _ last => (last.toLower.splitOn "necsuf").length > 1
    | _ => false

/-- docstring が `**` で始まるとき、最初の `**…**` の中身を返す。 -/
def leadingBold (doc : String) : String :=
  let d := doc.trimAsciiStart.toString
  if d.startsWith "**" then
    let rest := (d.drop 2).toString
    match rest.splitOn "**" with
    | head :: _ :: _ => (head.replace "\t" " ").replace "\n" " "
    | _ => ""
  else ""

#eval show CoreM Unit from do
  let env ← getEnv
  let moduleNames := env.header.moduleNames
  let isingModules : Array Bool := moduleNames.map isIsingModule
  let countedModules : Array Bool := moduleNames.map countedModule
  let inIsing (n : Name) : Bool :=
    match env.getModuleIdxFor? n with
    | some idx => isingModules[idx.toNat]!
    | none => false
  -- 親の宣言ごとに、証明が使う宣言を集める。
  let mut uses : Std.HashMap Name (Std.HashSet Name) := {}
  let mut roots : Std.HashSet Name := {}
  for (n, ci) in env.constants.toList do
    unless inIsing n do continue
    let r := rootDecl env n
    unless inIsing r do continue
    roots := roots.insert r
    let some rci := env.find? r | continue
    unless rci matches .thmInfo _ do continue
    -- 定理とその自動生成の補助の本体だけを見る。
    let some v := ci.value? (allowOpaque := true) | continue
    let mut s := uses.getD r {}
    for d in v.getUsedConstants do
      if inIsing d then
        let dr := rootDecl env d
        if dr != r && inIsing dr then s := s.insert dr
    uses := uses.insert r s
  let out ← IO.FS.Handle.mk (System.FilePath.mk ".lake/text-and-concrete-one-to-one/lean.tsv") .write
  for r in roots.toList do
    let some ridx := env.getModuleIdxFor? r | continue
    let m := moduleNames[ridx.toNat]!
    let u := userName r
    let kind := match env.find? r with
      | some (.thmInfo _) => "theorem"
      | _ => "other"
    let concrete := countedModules[ridx.toNat]! && !necSufOrDerivationName u
    let doc ← findDocString? env r
    let bold := leadingBold (doc.getD "")
    out.putStrLn s!"DECL\t{u}\t{m}\t{kind}\t{if concrete then 1 else 0}\t{bold}"
    for d in (uses.getD r {}).toList do
      out.putStrLn s!"USES\t{u}\t{userName d}"
