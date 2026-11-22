/-
必要十分版の各宣言が、仮定した性質を証明で使っているかを書き出す。docs/context の「Lean 必要十分版」の条件
「仮定が、具体版と同じ証明が実際に使っている性質だけであること」を機械で点検するための道具で、ライブラリの一部ではない。
使い方は同じフォルダの run.sh。lean/ で `lake build` の後に打つ。

書き出すもの（lean/.lake/necsuf-unused-assumptions/ の下、タブ区切り）。
- fields.tsv: 必要十分版の定理ごとに、仮定の Prop の構造体（K の法則の組・主張の前提）の葉の欄が、
  その定理から推移的にたどれる宣言の主張と証明のどこかに射影として現れるか。
- hyps.tsv: 必要十分版の宣言ごとに、Prop の引数が使われるか（別の宣言へそのまま渡すだけのものは、渡し先で使われるかで決める）。
- wholesale.tsv: 構造体の仮定を、欄を取り出さずにそのまま使う（∀ に渡すなど）か。そのまま使うなら欄ごとの判定はできない。
- labelled.tsv: 必要十分版の定理と、docstring に書いた本文のラベル。
-/
import CliffordMatrixIsomorphism
open Lean Meta

#eval show IO Unit from IO.FS.createDirAll ".lake/necsuf-unused-assumptions"

def libPrefix : Name := `CliffordMatrixIsomorphism

def isLib (env : Environment) (n : Name) : Bool :=
  match env.getModuleIdxFor? n with
  | some idx => libPrefix.isPrefixOf (env.header.moduleNames[idx.toNat]!)
  | none => false

def hasComp (n : Name) (c : String) : Bool := n.components.any (·.toString == c)

def isNecSufConst (env : Environment) (n : Name) : Bool :=
  isLib env n && (hasComp ((privateToUserName? n).getD n) "NecSuf" ||
    match env.getModuleIdxFor? n with
    | some idx => hasComp (env.header.moduleNames[idx.toNat]!) "NecSuf"
    | none => false)

/-- Prop の構造体（法則の組）か。 -/
def isLawStruct (env : Environment) (n : Name) : MetaM Bool := do
  if !(isNecSufConst env n) then return false
  if !(isStructure env n) then return false
  let some ci := env.find? n | return false
  forallTelescope ci.type fun _ b => return b.isProp

/-- 法則の組の葉（射影関数の名前）を、入れ子をほどいて並べる。 -/
partial def leaves (env : Environment) (s : Name) : MetaM (Array Name) := do
  let mut out := #[]
  for f in getStructureFields env s do
    let proj := s ++ f
    let some pci := env.find? proj | continue
    let sub? ← forallTelescope pci.type fun _ b => do
      let h := b.getAppFn
      if h.isConst then
        if ← isLawStruct env h.constName! then return some h.constName! else return none
      else return none
    match sub? with
    | some s' => out := out ++ (← leaves env s')
    | none => out := out.push proj
  return out

/-- 式の中の定数と射影ノードを集める。 -/
def collect (env : Environment) (e : Expr) : Std.HashSet Name := Id.run do
  let mut acc : Std.HashSet Name := {}
  for c in e.getUsedConstants do acc := acc.insert c
  let projs : Array Name := Id.run <| e.foldlM (m := Id) (init := (#[] : Array Name)) fun a sub =>
    match sub with
    | .proj s i _ => match (getStructureFields env s)[i]? with
        | some f => a.push (s ++ f)
        | none => a
    | _ => a
  for p in projs do acc := acc.insert p
  return acc

#eval show MetaM Unit from do
  let env ← getEnv
  let libConsts := env.constants.toList.filter fun (n, _) => isLib env n
  -- 法則の組と葉
  let mut lawStructs : Array Name := #[]
  for (n, _) in libConsts do
    if ← isLawStruct env n then lawStructs := lawStructs.push n
  let mut leafSet : Std.HashSet Name := {}
  let mut leafOf : Std.HashMap Name (Array Name) := {}
  for s in lawStructs do
    let ls ← leaves env s
    leafOf := leafOf.insert s ls
    for l in ls do leafSet := leafSet.insert l
  let destructNames : Std.HashSet Name := lawStructs.foldl (init := {}) fun a s =>
    (a.insert (s ++ `rec)).insert (s ++ `casesOn) |>.insert (s ++ `recOn)
  -- 直接の依存
  let mut direct : Std.HashMap Name (Array Name) := {}
  for (n, ci) in libConsts do
    let mut s := collect env ci.type
    if let some v := ci.value? (allowOpaque := true) then
      for c in collect env v do s := s.insert c
    direct := direct.insert n (s.toArray.filter fun c => isLib env c || leafSet.contains c || destructNames.contains c)
  -- 推移的な葉の使用（メモ化）
  let mut memo : Std.HashMap Name (Std.HashSet Name) := {}
  -- 依存の順に並べる（反復深さ優先）
  let order := Id.run do
    let mut visited : Std.HashSet Name := {}
    let mut out : Array Name := #[]
    for (n, _) in libConsts do
      if visited.contains n then continue
      let mut stack : Array (Name × Bool) := #[(n, false)]
      while h : stack.size > 0 do
        let (x, done) := stack.back
        stack := stack.pop
        if done then out := out.push x; continue
        if visited.contains x then continue
        visited := visited.insert x
        stack := stack.push (x, true)
        for d in (direct.getD x #[]) do
          if isLib env d && !visited.contains d && (direct.contains d) then stack := stack.push (d, false)
    return out
  for x in order do
    let mut s : Std.HashSet Name := {}
    for d in direct.getD x #[] do
      if leafSet.contains d || destructNames.contains d then s := s.insert d
      if let some t := memo.get? d then
        for y in t do s := s.insert y
    memo := memo.insert x s
  -- 必要十分版の定理ごとに、仮定の葉が使われているか
  let out ← IO.FS.Handle.mk ".lake/necsuf-unused-assumptions/fields.tsv" .write
  for (n, ci) in libConsts do
    unless isNecSufConst env n do continue
    unless ci matches .thmInfo _ do continue
    let u := (privateToUserName? n).getD n
    if u.isInternalDetail then continue
    let used := memo.getD n {}
    forallTelescope ci.type fun xs _ => do
      for x in xs do
        let t ← inferType x
        let h := t.getAppFn
        if h.isConst && lawStructs.contains h.constName! then
          let s := h.constName!
          for l in leafOf.getD s #[] do
            let st :=
              if used.contains l then "used"
              else if lawStructs.any (fun s' => used.contains (s' ++ `rec) || used.contains (s' ++ `casesOn)) then "unknown"
              else "unused"
            out.putStrLn s!"{u}\t{(← x.fvarId!.getUserName)}\t{s}\t{l}\t{st}"
  IO.println s!"law structures: {lawStructs.size}, leaves: {leafSet.size}"

/-- fvar `x` の出現を、直接の使用と「定数 E の j 番目の引数にそのまま渡す」に分ける。 -/
partial def occ (env : Environment) (x : FVarId) (e : Expr) : StateM (Bool × Array (Name × Nat)) Unit := do
  if !e.containsFVar x then return
  match e with
  | .fvar y => if y == x then modify fun (_, d) => (true, d)
  | .app .. =>
    let f := e.getAppFn
    let args := e.getAppArgs
    if f.isConst && isLib env f.constName! then
      for i in [0:args.size] do
        let a := args[i]!
        if a == .fvar x then modify fun (b, d) => (b, d.push (f.constName!, i))
        else occ env x a
    else
      occ env x f
      for a in args do occ env x a
  | .lam _ t b _ | .forallE _ t b _ => do occ env x t; occ env x b
  | .letE _ t v b _ => do occ env x t; occ env x v; occ env x b
  | .mdata _ b => occ env x b
  | .proj _ _ b => occ env x b
  | _ => pure ()

#eval show MetaM Unit from do
  let env ← getEnv
  let libConsts := env.constants.toList.filter fun (n, _) => isLib env n
  -- 各宣言の Prop の引数ごとに (直接使うか, 渡す先)
  let mut info : Std.HashMap (Name × Nat) (Bool × Array (Name × Nat)) := {}
  let mut propArgs : Std.HashMap Name (Array (Nat × Name)) := {}
  for (n, ci) in libConsts do
    let some v := ci.value? (allowOpaque := true) | continue
    let r ← forallTelescope ci.type fun xs concl => do
      let body := (mkAppN v xs).headBeta
      let mut res := #[]
      for i in [0:xs.size] do
        let x := xs[i]!
        let t ← inferType x
        unless ← isProp t do continue
        let rest := (← xs[i+1:].toArray.mapM inferType).push concl
        let ((), st) := (do
            for r in rest do occ env x.fvarId! r
            occ env x.fvarId! body).run (false, #[])
        res := res.push (i, (← x.fvarId!.getUserName), st)
      return res
    propArgs := propArgs.insert n (r.map fun (i, nm, _) => (i, nm))
    for (i, _, st) in r do info := info.insert (n, i) st
  -- 最小不動点
  let mut used : Std.HashSet (Name × Nat) := {}
  for (k, (b, _)) in info do if b then used := used.insert k
  let mut changed := true
  while changed do
    changed := false
    for (k, (_, ds)) in info do
      if used.contains k then continue
      if ds.any (fun d => used.contains d || !(info.contains d)) then
        used := used.insert k; changed := true
  let out ← IO.FS.Handle.mk ".lake/necsuf-unused-assumptions/hyps.tsv" .write
  for (n, ci) in libConsts do
    unless isNecSufConst env n do continue
    let u := (privateToUserName? n).getD n
    if u.isInternalDetail then continue
    let kind := match ci with | .thmInfo _ => "thm" | .defnInfo _ => "def" | _ => "other"
    for (i, nm) in propArgs.getD n #[] do
      out.putStrLn s!"{u}\t{kind}\t{i}\t{nm}\t{if used.contains (n, i) then "used" else "unused"}"
  IO.println "hyps done"

/-- x の出現を、射影（欄の取り出し）・lib の定数への受け渡し・それ以外（束のまま使う）に分ける。 -/
partial def occW (env : Environment) (x : FVarId) (e : Expr) : StateM (Bool × Array (Name × Nat)) Unit := do
  if !e.containsFVar x then return
  match e with
  | .fvar y => if y == x then modify fun (_, d) => (true, d)
  | .proj _ _ (.fvar y) => if y == x then pure () else pure ()
  | .app .. =>
    let f := e.getAppFn
    let args := e.getAppArgs
    if f.isConst && isLib env f.constName! then
      let isProjFn := (env.getProjectionFnInfo? f.constName!).isSome
      for i in [0:args.size] do
        let a := args[i]!
        if a == .fvar x then
          if isProjFn then pure () else modify fun (b, d) => (b, d.push (f.constName!, i))
        else occW env x a
    else
      occW env x f
      for a in args do occW env x a
  | .lam _ t b _ | .forallE _ t b _ => do occW env x t; occW env x b
  | .letE _ t v b _ => do occW env x t; occW env x v; occW env x b
  | .mdata _ b => occW env x b
  | .proj _ _ b => occW env x b
  | _ => pure ()

#eval show MetaM Unit from do
  let env ← getEnv
  let libConsts := env.constants.toList.filter fun (n, _) => isLib env n
  let mut info : Std.HashMap (Name × Nat) (Bool × Array (Name × Nat)) := {}
  let mut names : Std.HashMap (Name × Nat) Name := {}
  for (n, ci) in libConsts do
    if (env.getProjectionFnInfo? n).isSome then continue
    let some v := ci.value? (allowOpaque := true) | continue
    let r ← forallTelescope ci.type fun xs concl => do
      let body := (mkAppN v xs).headBeta
      let mut res := #[]
      for i in [0:xs.size] do
        let x := xs[i]!
        let t ← inferType x
        unless ← isProp t do continue
        let h := t.getAppFn
        unless h.isConst && isStructure env h.constName! && isLib env h.constName! do continue
        let rest := (← xs[i+1:].toArray.mapM inferType).push concl
        let ((), st) := (do
            for r in rest do occW env x.fvarId! r
            occW env x.fvarId! body).run (false, #[])
        res := res.push (i, (← x.fvarId!.getUserName), st)
      return res
    for (i, nm, st) in r do
      info := info.insert (n, i) st
      names := names.insert (n, i) nm
  let mut whole : Std.HashSet (Name × Nat) := {}
  for (k, (b, _)) in info do if b then whole := whole.insert k
  let mut changed := true
  while changed do
    changed := false
    for (k, (_, ds)) in info do
      if whole.contains k then continue
      -- 渡す先が lib の定数で、その引数を調べていない（束の型でない等）なら束のまま使うとみなす
      if ds.any (fun d => whole.contains d || !(info.contains d)) then
        whole := whole.insert k; changed := true
  let out ← IO.FS.Handle.mk ".lake/necsuf-unused-assumptions/wholesale.tsv" .write
  for (k, nm) in names do
    let u := (privateToUserName? k.1).getD k.1
    out.putStrLn s!"{u}\t{nm}\t{if whole.contains k then "whole" else "fields"}"

#eval show CoreM Unit from do
  let env ← getEnv
  let out ← IO.FS.Handle.mk ".lake/necsuf-unused-assumptions/labelled.tsv" .write
  for (n, ci) in env.constants.toList do
    unless ci matches .thmInfo _ do continue
    let u := (privateToUserName? n).getD n
    unless u.components.any (·.toString == "NecSuf") do continue
    let some d ← findDocString? env n | continue
    if (d.splitOn "本文 `").length > 1 then
      let lbl := ((d.splitOn "本文 `")[1]!.splitOn "`")[0]!
      let mod := match env.getModuleIdxFor? n with | some i => env.header.moduleNames[i.toNat]!.toString | none => ""
      out.putStrLn s!"{u}\t{lbl}\t{mod}"
