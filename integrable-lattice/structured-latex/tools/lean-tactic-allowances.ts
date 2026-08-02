/**
 * **検査 T の台帳**（`field_simp` の直後の `ring` として現存する対）。
 *
 * 型と、なぜ宣言制にするのかは `lean-tactic-model.ts` の doc を正本とする。要点だけ:
 *
 * - **ここに載っている対は、いずれも `ring` が必要である。**
 *   根拠は `lake build` が通っていること——不要なら Lean が `No goals to be solved` で落ちる。
 *   すなわち**この台帳の正しさは、検査ではなくビルドが担保している**。
 * - **新しく書かれた対はここに無いので即座に赤くなる。** それがこの台帳の目的である。
 *   新しい対を足すときは、**先に `ring` 無しでビルドして落ちることを確かめてから**登録すること
 *   （落ちなければ `ring` は不要であり、登録ではなく削除が正しい）。
 * - **直したのに宣言が残る状態は作れない。** 宣言が指す宣言名がファイルに無い／
 *   その宣言の中に対がもう無い／個数が合わない、のいずれでも落ちる。
 *
 * 初期値は cycle 26 step 3 の実測（10 件）。`lake build` は同 step で
 * `Build completed successfully (8679 jobs)` を実測している。
 */

import type { TacticPairAllowance } from "./lean-tactic-model.ts";

const BUILD_PASSES =
  "cycle 26 step 3 の時点で `lake build` が通っている（8679 jobs）。" +
  "この `ring` が不要なら Lean が `No goals to be solved` で落ちるので、必要である。";

export const LEAN_TACTIC_ALLOWANCES: readonly TacticPairAllowance[] = [
  {
    file: "IntegrableLattice/Cycle24Corrections.lean",
    declaration: "G4_note42_c_side",
    index: 0,
    reason: BUILD_PASSES,
  },
  {
    file: "IntegrableLattice/Cycle24Corrections.lean",
    declaration: "corollary_G6_c_as_Theta",
    index: 0,
    reason: BUILD_PASSES,
  },
  {
    file: "IntegrableLattice/Cycle25Corrections.lean",
    declaration: "U1_c_from_M3_M4",
    index: 0,
    reason: BUILD_PASSES,
  },
  {
    file: "IntegrableLattice/GeneralTowerClosedForm.lean",
    declaration: "S0_closed",
    index: 0,
    reason: BUILD_PASSES,
  },
  {
    file: "IntegrableLattice/GeneralTowerClosedForm.lean",
    declaration: "S1_closed",
    index: 0,
    reason: BUILD_PASSES,
  },
  {
    file: "IntegrableLattice/GeneralTowerClosedForm.lean",
    declaration: "S1_decomp",
    index: 0,
    reason: BUILD_PASSES,
  },
  {
    file: "IntegrableLattice/GeneralTowerClosedForm.lean",
    declaration: "S0_decomp",
    index: 0,
    reason: BUILD_PASSES,
  },
  {
    file: "IntegrableLattice/GeneralTowerClosedForm.lean",
    declaration: "theorem_G1",
    index: 0,
    reason: BUILD_PASSES,
  },
  {
    file: "IntegrableLattice/PropT.lean",
    declaration: "prod_A_sub_zeta_eq",
    index: 0,
    reason: BUILD_PASSES,
  },
  {
    file: "IntegrableLattice/PropT.lean",
    declaration: "prod_A_sub_zeta_eq",
    index: 1,
    reason: BUILD_PASSES,
  },
];
