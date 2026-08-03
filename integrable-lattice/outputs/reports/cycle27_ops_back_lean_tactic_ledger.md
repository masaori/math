# cycle 27 step 5: `field_simp` 直後の `ring` の台帳 10 件を、実際に外して落として裏取りした

変更: `structured-latex/tools/lean-tactic-allowances.ts`（根拠の文言のみ）。
**`lean/` の中身は 1 バイトも変えていない**（測定のたびに `git checkout` で戻し、最後に作業ツリーが
きれいであることを確認した）。

## 何が問題だったか

cycle 26 step 3 が作った検査 T の台帳は、10 件すべてに同じ根拠を書いていた。

> cycle 26 step 3 の時点で `lake build` が通っている（8679 jobs）。
> この `ring` が不要なら Lean が `No goals to be solved` で落ちるので、必要である。

これは**推論であって実測ではない**。「不要なら落ちるはず」という逆向きの論理に依っており、
本当に必要かどうかを確かめてはいない。cycle 26 総括自身が
「いまの根拠は『ビルドが通っているから必要なはず』という論理であって実測ではない」と書いて
cycle 27 へ送った。

## やったこと

**10 件を 1 つずつ、その `ring` だけを外してビルドした。** 対象のモジュールだけを
`lake build <module>` で作り、結果を記録し、`git checkout` でファイルを戻す、を 10 回繰り返した。

| ファイル | 宣言 | `ring` を外した結果 |
|---|---|---|
| `Cycle24Corrections.lean` | `G4_note42_c_side` | **`unsolved goals` で落ちた** |
| `Cycle24Corrections.lean` | `corollary_G6_c_as_Theta` | **`unsolved goals` で落ちた** |
| `Cycle25Corrections.lean` | `U1_c_from_M3_M4` | **`unsolved goals` で落ちた** |
| `GeneralTowerClosedForm.lean` | `S0_closed` | **`unsolved goals` で落ちた** |
| `GeneralTowerClosedForm.lean` | `S1_closed` | **`unsolved goals` で落ちた** |
| `GeneralTowerClosedForm.lean` | `S1_decomp` | **`unsolved goals` で落ちた** |
| `GeneralTowerClosedForm.lean` | `S0_decomp` | **`unsolved goals` で落ちた** |
| `GeneralTowerClosedForm.lean` | `theorem_G1` | **`unsolved goals` で落ちた** |
| `PropT.lean` | `prod_A_sub_zeta_eq`（1 つ目） | **`unsolved goals` で落ちた** |
| `PropT.lean` | `prod_A_sub_zeta_eq`（2 つ目） | **`unsolved goals` で落ちた** |

**10 / 10 件が落ちた。台帳の主張は正しかった。**

落ち方は 10 件とも `unsolved goals` である。すなわち `field_simp` のあとに**目標が残っており**、
`ring` がそれを閉じている。「不要な `ring` なら `No goals to be solved` で落ちる」という
cycle 26 の推論とは逆側の証拠で、**`ring` が実際に仕事をしていることを直接示している**。

台帳の根拠の文言を、推論から実測へ書き換えた。

## 検証

- 測定 10 回。各回とも対象モジュールだけをビルドし、`git checkout` で復元した
- 測定後の `git status`: `lean/` に差分なし
- `verify:lean-tactics`（検査 T）違反 0 件（台帳 10 件がすべて実在の対に当たる）
- `npm run check` 24 段・exit 0

## 限界（正直に書く）

- **測ったのは「その `ring` を消すと落ちる」ことだけ**である。
  「`ring` がその位置にあるのが最良か」（`field_simp` の呼び方を変えれば要らなくなるか、
  別のタクティクのほうが速いか）は測っていない。
- **この裏取りは 1 回きりの測定である。** 台帳は「対が実在すること」を毎回確かめるが、
  「`ring` が今も必要であること」を毎回測り直しはしない（10 回のビルドを毎回回すのは重い）。
  mathlib が更新されて `field_simp` の挙動が変われば、台帳の根拠は静かに古くなる。
