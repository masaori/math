/-
具体版の定義と主張に出る、ライブラリの外（mathlib・Lean 本体）の記号の書き出し。
`check.sh` が `lake env lean` で実行する。ライブラリの一部ではない。

数える宣言は具体版のものだけで、分類は繋がりの検査（`scripts/connection-to-final-theorem/Connection.lean`）と同じである。
必要十分版・導出・本文から退避した経路の置き場（`RoutesNotAdopted`）を除く。

見るのは宣言の「定義と主張」だけで、証明は見ない。
- 全ての宣言の主張（型）。帰納型・構造体は構成子の型（欄の型）と欄の既定値を見る。
- 定義（`def`・`abbrev`・`instance`・`opaque`）の本体。`match` の補助と整礎再帰の補助（`_unary`・`_mutual`）の
  本体と型も、親の定義の本体として見る。
- 定理の本体（証明）は見ない。定義の本体の中に現れる証明の項（定理の定数を頭に持つ項）も、その下ごと見ない。

記号として書き出すのは、ライブラリの外の定数のうち、次を除いたものである。
- 定理（証明の部品であって記号ではない）。
- 型クラスの解決に登録されたインスタンスと、親の構造体への射影（`NormedAddCommGroup.toNorm` など）。どの構成かは
  下の「演算@型@インスタンス」で書き出す。インスタンスとして渡す引数（`[inst : …]` の引数）の中は辿り、
  登録されていない定義（`letI` で入れる `Matrix.frobeniusNormedRing` など）が在れば書き出す。
- 帰納型の再帰子の類（`Nat.rec`・`Nat.casesOn`・`Nat.brecOn`・`Nat.below` など）は、その帰納型の名前（`Nat`）として書き出す。
  構造的再帰の定義の本体に現れるのは、本文の帰納法による定義の Lean の翻訳だからである。
- 構造的再帰の翻訳だけが作る組の型（`PProd`・`PUnit` とその構成子・射影）。本文のどの記号にも当たらない。

型クラスの演算（`HAdd.hAdd`・`HPow.hPow`・`HSMul.hSMul`・`OfNat.ofNat`・`LE.le`・`Norm.norm` など、型クラスの構造体の射影）は、
型クラスの引数の全て（働く型。`OfNat` は数の値も）の頭と、演算の中身を決めるインスタンスの頭の定数を添えて、
`HPow.hPow@Real,Nat,Real@NPow.toPow`（自然数の冪）・`HPow.hPow@Real,Real,Real@Real.instPow`（実数の冪）のように書き出す。
インスタンスの頭は、親への射影と、異なる型の演算を同じ型の演算から作るだけのインスタンス（`instHMul` など）を通り抜けて取る。
同じ記号でも本文では別の定義になるもの（実数の和と行列の和、自然数の冪と実数の冪、mathlib の行列の積と
ライブラリが置いた積、ℂ の行列と ℝ の行列）を、分けて数えるためである。行列は成分の型まで `Matrix[Complex]` と書く。
インスタンス引数をとる型クラスの演算でない関数（`Finset.sum`・`Matrix.trace`・`nhds` など）も、最初のインスタンス引数より前の
引数の頭と各インスタンス引数の頭を添えて `Finset.sum@Complex,Fin@Complex.instAddCommMonoid` のように書き出す。型が変数なら `?`、関数の型なら `→`、λ なら `fun` を添える。

書き出すもの（タブ区切り、一行に一件）: `UNDEF  <具体版の宣言>  <記号>`。
-/
import Ising2D
open Lean

def userName (n : Name) : Name := (privateToUserName? n).getD n

def findParent (env : Environment) (p : Name) : Option Name :=
  if env.contains p then some p
  else match privateToUserName? p with
    | some u => if env.contains u then some u else none
    | none => none

def isDigits (s : String) : Bool :=
  !s.isEmpty && s.all (fun c => c.isDigit || c == '_') && s.front.isDigit && s.back.isDigit

def numberedGenerated (s : String) : Bool :=
  ["eq_", "match_", "proof_"].any fun pre => s.startsWith pre && isDigits (s.drop pre.length).toString

/-- 自動生成の定数・構成子・射影を、それを生んだ宣言へ戻す（`Connection.lean` と同じ）。 -/
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

def countedModule (m : Name) : Bool :=
  isIsingModule m && !hasComponent m "NecSuf" && !m.getString!.endsWith "FromNecSuf" &&
    !hasComponent m "RoutesNotAdopted"

def necSufOrDerivationName (u : Name) : Bool :=
  hasComponent u "NecSuf" ||
    match u with
    | .str _ last => (last.toLower.splitOn "necsuf").length > 1
    | _ => false

/-- 帰納型の再帰子の類なら、その帰納型の名前。 -/
def recursorFamily (env : Environment) (d : Name) : Option Name :=
  match d with
  | .str p s =>
    if ["rec", "recOn", "casesOn", "brecOn", "below", "binductionOn", "ibelow"].contains s then
      match env.find? p with
      | some (.inductInfo _) => some p
      | _ => none
    else none
  | _ => none

def compilationArtifact (d : Name) : Bool :=
  [``PProd, ``PProd.mk, ``PProd.fst, ``PProd.snd, ``PUnit, ``PUnit.unit].contains d

/-- 型クラスの解決に登録されたインスタンスか。登録されていない定義（`letI` や `attribute [local instance]` で入れる
`Matrix.frobeniusNormedRing` など）は、ここでは偽で、記号として書き出す。 -/
def isInstanceConst (env : Environment) (d : Name) : Bool :=
  Meta.isInstanceCore env d

/-- 型クラスの構造体の射影（`HMul.hMul`・`NormedAddCommGroup.toNorm` など）なら、その射影の情報。 -/
def classProjection? (env : Environment) (d : Name) : Option ProjectionFunctionInfo :=
  match env.getProjectionFnInfo? d with
  | some info => if info.fromClass then some info else none
  | none => none

/-- 異なる型の演算を同じ型の演算から作るだけの Lean 本体のインスタンス。演算の中身は、その引数のインスタンスが決める。 -/
def liftingInstance (d : Name) : Bool :=
  [``instHAdd, ``instHMul, ``instHSub, ``instHDiv, ``instHMod, ``instHPow, ``instHSMul,
    ``instHAppendOfAppend, ``instPowNat].contains d

/-- 定数の型の束縛子のうち、インスタンスとして渡す引数の位置。 -/
def instArgMask (ty : Expr) : Array Bool := Id.run do
  let mut e := ty
  let mut out := #[]
  while true do
    match e with
    | .forallE _ _ b bi =>
      out := out.push bi.isInstImplicit
      e := b
    | _ => break
  return out

structure Walk where
  visited : Std.HashSet Expr := {}
  symbols : Std.HashSet String := {}
  masks : Std.HashMap Name (Array Bool) := {}

abbrev WalkM := StateT Walk (ReaderT Environment Id)

def inLibrary (env : Environment) (n : Name) : Bool :=
  match env.getModuleIdxFor? n with
  | some idx => isIsingModule env.header.moduleNames[idx.toNat]!
  | none => false

partial def carrierHead (e : Expr) : String :=
  match e.getAppFn with
  | .const c _ =>
    -- 行列は成分の型まで書く（ℂ の行列の積と ℝ の行列の積は本文では別の定義である）。
    if c == ``Matrix && e.getAppNumArgs == 3 then s!"Matrix[{carrierHead e.appArg!}]"
    else (userName c).toString
  | .forallE .. => "→"
  | .sort _ => "Sort"
  | .lit (.natVal n) => toString n
  | .lam .. => "fun"
  | _ => "?"

def record (s : String) : WalkM Unit :=
  modify fun w => { w with symbols := w.symbols.insert s }

def maskOf (env : Environment) (f : Name) : WalkM (Array Bool) := do
  if let some m := (← get).masks.get? f then return m
  let m := match env.find? f with
    | some ci => instArgMask ci.type
    | none => #[]
  modify fun w => { w with masks := w.masks.insert f m }
  return m

/-- インスタンスの項の頭の定数。親の構造体への射影と、異なる型の演算を作るだけのインスタンスは通り抜ける。 -/
partial def instanceHead (env : Environment) (e : Expr) : String :=
  match e.getAppFn with
  | .const c _ =>
    let args := e.getAppArgs
    if let some info := classProjection? env c then
      if info.numParams < args.size then instanceHead env args[info.numParams]! else (userName c).toString
    else if liftingInstance c then
      match args.back? with
      | some a => instanceHead env a
      | none => (userName c).toString
    else (userName c).toString
  | _ => "?"

mutual
/-- 型クラスの演算と、それ以外のライブラリの外の定数を書き出す。演算は、働く型（型クラスの引数の全て）と、
演算の中身を決めるインスタンスの頭の定数を添えて `HPow.hPow@Real,Nat,Real@NPow.toPow` の形にする。 -/
partial def recordHead (c : Name) (args : Array Expr) : WalkM Unit := do
  let env ← read
  if inLibrary env c then return
  if let some info := classProjection? env c then
    if args.isEmpty then
      record c.toString
    else
      let types := (args.extract 0 info.numParams).toList.map carrierHead
      let inst := if info.numParams < args.size then instanceHead env args[info.numParams]! else "?"
      record s!"{c}@{",".intercalate types}@{inst}"
  else if let some ind := recursorFamily env c then record ind.toString
  else if compilationArtifact c then pure ()
  else
    -- インスタンス引数をとる関数（`Finset.sum`・`Matrix.trace`・`nhds` など）は、どの和・どの位相かを
    -- インスタンスが決めるので、最初のインスタンス引数より前の引数の頭と、各インスタンス引数の頭を添える。
    let mask ← maskOf env c
    match mask.findIdx? id with
    | none => record c.toString
    | some first =>
      let types := (args.extract 0 first).toList.map carrierHead
      let insts := (List.range mask.size).filter (fun i => mask[i]!) |>.map fun i =>
        if i < args.size then instanceHead env args[i]! else "?"
      record s!"{c}@{",".intercalate types}@{",".intercalate insts}"

/-- インスタンスとして渡す項。登録されたインスタンスと親への射影は書き出さずに引数を辿り、
それ以外の定数（登録されていない定義を `letI` で入れたものなど）は書き出す。 -/
partial def visitInstance (e : Expr) : WalkM Unit := do
  let env ← read
  match e.getAppFn with
  | .const c _ =>
    if inLibrary env c then return
    match env.find? c with
    | some (.thmInfo _) => return
    | _ => pure ()
    if isInstanceConst env c || (classProjection? env c).isSome || liftingInstance c then
      for a in e.getAppArgs do visitInstance a
    else visit e
  | _ => visit e

partial def visit (e : Expr) : WalkM Unit := do
  if (← get).visited.contains e then return
  modify fun w => { w with visited := w.visited.insert e }
  let env ← read
  match e with
  | .app .. =>
    let f := e.getAppFn
    let args := e.getAppArgs
    match f with
    | .const c _ =>
      match env.find? c with
      | some (.thmInfo _) => return  -- 証明の項はその下ごと見ない
      | _ => pure ()
      if isInstanceConst env c then
        visitInstance e
        return
      let mask ← maskOf env c
      recordHead c args
      for i in [0:args.size] do
        if mask.getD i false then visitInstance args[i]!
        else visit args[i]!
    | _ =>
      visit f
      for a in args do visit a
  | .const c _ =>
    match env.find? c with
    | some (.thmInfo _) => return
    | _ => pure ()
    if isInstanceConst env c then return
    recordHead c #[]
  | .lam _ t b _ => visit t; visit b
  | .forallE _ t b _ => visit t; visit b
  | .letE _ t v b _ => visit t; visit v; visit b
  | .mdata _ b => visit b
  | .proj s _ b =>
    if !inLibrary env s then record s.toString
    visit b
  | _ => pure ()
end

/-- `match` の補助・整礎再帰の補助のように、親の定義の本体の一部として見る自動生成の定義か。 -/
def auxiliaryDefinition (n : Name) : Bool :=
  match n with
  | .str _ s => s.startsWith "match_" || s == "_unary" || s == "_mutual"
  | _ => false

/-- 構造体の欄の既定値か。構造体の定義の一部として見る。 -/
def fieldDefault (n : Name) : Bool :=
  match n with
  | .str _ s => s == "_default"
  | _ => false

#eval show CoreM Unit from do
  let env ← getEnv
  let moduleNames := env.header.moduleNames
  let countedModules : Array Bool := moduleNames.map countedModule
  let out ← IO.FS.Handle.mk (System.FilePath.mk ".lake/mathlib-symbols-undefined-in-text/symbols.tsv") .write
  let mut perDecl : Std.HashMap Name (Std.HashSet String) := {}
  let mut total : Nat := 0
  for (n, ci) in env.constants.toList do
    unless inLibrary env n do continue
    let r := rootDecl env n
    let some ridx := env.getModuleIdxFor? r | continue
    unless countedModules[ridx.toNat]! do continue
    if necSufOrDerivationName (userName r) then continue
    -- 見る式: 宣言そのものは主張と（定義なら）本体、構成子は型、match の補助の定義は型と本体。
    let rootIsDefinition := match env.find? r with
      | some (.defnInfo _) => true
      | some (.opaqueInfo _) => true
      | _ => false
    let isCtorOfRoot := match ci with
      | .ctorInfo _ => true
      | _ => false
    let exprs : Array Expr :=
      if n == r then
        match ci with
        | .defnInfo d => #[ci.type, d.value]
        | .opaqueInfo d => #[ci.type, d.value]
        | _ => #[ci.type]
      else if isCtorOfRoot then #[ci.type]
      else if (auxiliaryDefinition n && rootIsDefinition) || fieldDefault n then
        match ci with
        | .defnInfo d => #[ci.type, d.value]
        | _ => #[]
      else #[]
    if exprs.isEmpty then continue
    if n == r then total := total + 1
    let ((), w) := (exprs.forM visit).run {} |>.run env
    let prev := perDecl.getD r {}
    perDecl := perDecl.insert r (w.symbols.fold (init := prev) fun s x => s.insert x)
  for (r, syms) in perDecl.toList do
    for s in syms.toList do
      out.putStrLn s!"UNDEF\t{userName r}\t{s}"
  out.putStrLn s!"TOTAL\t{total}"
