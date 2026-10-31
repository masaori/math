# SageMath Check: c_between_Lambda_half_and_twice_Lambda_half

## 対象

**対象ラベル**: `c_between_Lambda_half_and_twice_Lambda_half` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
  （ブロック `column_limit_claim_c_between_Lambda_half_and_twice_Lambda_half`）
- 主張: `K_1, K_2 > 0`、`M ≥ 2` で `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M`
- 範囲: proof の Step 1（`c(M) ≥ c_+(M) = Λ^{(1/2)}_M`）と Step 2（`u := |x|`、`v := u + εu` からの各行）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_step_chain.sage | Step 1: `c_+(M) ≤ c(M)` と `c_+(M) = Λ^{(1/2)}_M`（`c_+(M)` は `W` を `F^{(+)} ∩ ℝ^{2^M}` の正規直交実基底へ制限した行列の最大固有値として作る）。Step 2 の前提（`ε^⊤ = ε`、`ε² = I`、`ε` は置換行列、`εW = Wε`、`W^⊤ = W`、`W` の成分が正）と、単位ベクトル `x`（乱数 6 本、`W` の最大固有ベクトル、`εy = −y` の実ベクトル）ごとに各行（`u^⊤Wu ≥ x^⊤Wx`、`εu ≥ 0`、`‖εu‖ = ‖u‖ = 1`、`εv = v`、`v ≥ u ≥ 0`、`‖v‖² = 2 + 2u^⊤εu ≤ 4`、`v^⊤Wv` の 5 行の等号と `≥ 2u^⊤Wu`、最後の不等号の鎖）。結論 `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M`。下界の鋭さの確認: 下界を `1.01Λ`、上界を `0.99Λ` にしたものがすべての組で破れること（数値では `c = c_+ = Λ` なので、上からの評価の検査にはならない）。否定コントロール: `‖v‖² ≤ 4` を `‖v‖² ≤ 2` にすると破れる `x` があること、`F^{(+)}` を `F^{(−)}` に替えた `c(M) ≤ 2c_−(M)`（`c_−` は `F^{(−)} ∩ ℝ^{2^M}` 上の上限）が破れる組があること（上からの評価が `εv = v` に依ることの対照。`M ∈ {2,3,4,5}`、`(K_1,K_2)` 6 組。臨界点上を含む） | PASS | 等式の各行の残差 ≤ 1.0e-14、不等式の各行の違反 0 件（`x` 192 本）、結論の違反 0 件。下界の鋭さの確認は 2 つとも破れた。否定コントロールも破れた（`‖v‖² ≤ 2` は 192 本すべて、`c ≤ 2c_−` は 24 組のうち 4 組） |

## 備考

- **ℝ 脱出（指数評価・完備性）**: `W` は行列の指数関数から作るので成分が超越数になり、`c(M)`・`c_+(M)` は実数の上限、
  `Λ^{(1/2)}_M` は実数の指数関数と `arccosh` の値である。厳密計算できないので倍精度 `CDF`・`RDF` で計算した。
- `c(M)`・`c_+(M)` を最大固有値として作るのは検算の手段である。本文は上限として定義し、固有値の存在を使わない。
- 行ごとの判定の本体は `053_claim_even_sector_closing/check_05_free_energy_limit.sage` の (1)〜(3) と同じである
  （この主張は 2026-10-31 に `onsager_exact_solution` の証明の Step 2・Step 3 を独立させたもの）。
  数値では `c(M) = c_+(M)` も成り立つ（(3')。本文はこれを使わない）。
- 共通定義は `053_claim_even_sector_closing/_prelude.sage` を使う。

## 実行方法

```bash
cd sagemath/check/c_between_Lambda_half_and_twice_Lambda_half
sage check_step_chain.sage
```

実行ログは `logs/` に保存してある（2026-10-31）。
