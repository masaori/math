/**
 * **検査 T の台帳**（`field_simp` の直後の `ring` として現存する対）。
 *
 * 型と、なぜ宣言制にするのかは `lean-tactic-model.ts` の doc を正本とする。要点だけ:
 *
 * - **ここに載っている対は、いずれも `ring` が必要である。**
 *   根拠は**実測**である——cycle 27 step 5 で 10 件すべてについて `ring` を 1 つずつ外してビルドし、
 *   **10 件とも `unsolved goals` で落ちた**。cycle 26 step 3 の時点の根拠は
 *   「ビルドが通っているから必要なはず」という推論にとどまっていた。
 * - **新しく書かれた対はここに無いので即座に赤くなる。** それがこの台帳の目的である。
 *   新しい対を足すときは、**先に `ring` 無しでビルドして落ちることを確かめてから**登録すること
 *   （落ちなければ `ring` は不要であり、登録ではなく削除が正しい）。
 * - **直したのに宣言が残る状態は作れない。** 宣言が指す宣言名がファイルに無い／
 *   その宣言の中に対がもう無い／個数が合わない、のいずれでも落ちる。
 *
 * 初期値は cycle 26 step 3 の実測（10 件）。cycle 27 step 5 で、その 10 件すべてが
 * 本当に `ring` を要することを外して落として確かめた。
 */

import type { TacticPairAllowance } from "./lean-tactic-model.ts";

const MEASURED =
  "cycle 27 step 5 で**実際に `ring` を外してビルドし、`unsolved goals` で落ちることを確かめた**。" +
  "cycle 26 step 3 の時点の根拠は「`lake build` が通っているから必要なはず」という論理だったが、" +
  "それは「不要なら `No goals to be solved` で落ちるはず」という逆向きの推論であって実測ではない。" +
  "10 件すべてを 1 つずつ外して測り直した（10/10 が落ちた）。";

export const LEAN_TACTIC_ALLOWANCES: readonly TacticPairAllowance[] = [
  {
    file: "IntegrableLattice/Cycle24Corrections.lean",
    declaration: "G4_note42_c_side",
    index: 0,
    reason: MEASURED,
  },
  {
    file: "IntegrableLattice/Cycle24Corrections.lean",
    declaration: "corollary_G6_c_as_Theta",
    index: 0,
    reason: MEASURED,
  },
  {
    file: "IntegrableLattice/Cycle25Corrections.lean",
    declaration: "U1_c_from_M3_M4",
    index: 0,
    reason: MEASURED,
  },
  {
    file: "IntegrableLattice/GeneralTowerClosedForm.lean",
    declaration: "S0_closed",
    index: 0,
    reason: MEASURED,
  },
  {
    file: "IntegrableLattice/GeneralTowerClosedForm.lean",
    declaration: "S1_closed",
    index: 0,
    reason: MEASURED,
  },
  {
    file: "IntegrableLattice/GeneralTowerClosedForm.lean",
    declaration: "S1_decomp",
    index: 0,
    reason: MEASURED,
  },
  {
    file: "IntegrableLattice/GeneralTowerClosedForm.lean",
    declaration: "S0_decomp",
    index: 0,
    reason: MEASURED,
  },
  {
    file: "IntegrableLattice/GeneralTowerClosedForm.lean",
    declaration: "theorem_G1",
    index: 0,
    reason: MEASURED,
  },
  {
    file: "IntegrableLattice/PropT.lean",
    declaration: "prod_A_sub_zeta_eq",
    index: 0,
    reason: MEASURED,
  },
  {
    file: "IntegrableLattice/PropT.lean",
    declaration: "prod_A_sub_zeta_eq",
    index: 1,
    reason: MEASURED,
  },
];
