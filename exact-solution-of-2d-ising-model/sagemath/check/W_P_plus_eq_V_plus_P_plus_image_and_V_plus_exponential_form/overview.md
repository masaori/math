# SageMath Check: W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form

## 対象

**対象ラベル**: `W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`
  （ブロック `projection_and_jordan_wigner_claim_W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form`）
- 主張（`ε` の固有値 `+1` の固有空間への射影と Jordan–Wigner 表示の章の章末の主張）: `M_col ≥ 2`、`K_1, K_2 > 0` のとき
  (1) `W P^{(+)} = V^{(+)} P^{(+)}`、(2) `F^{(+)} = {x | εx = x} = im P^{(+)}`、
  (3) `V^{(+)} = exp((i/2)K_1H_1^{(+)}) (2 sinh 2K_2)^{M_col/2} exp(iK_2^*H_2) exp((i/2)K_1H_1^{(+)})`
- 範囲: 主張の (1)(2)(3)。証明は既存の三つの主張（`symmetrized_transfer_matrix_on_sectors`、
  `epsilon_projector_properties` (2)、`V_plus_exponential_form`）を挙げるだけなので、主張の両辺を独立に作って比べる。
  各主張の式変形の一行ずつの検査は、それぞれの検査（`044_claim_max_eigenvalue/` の `W P^{(+)}` の検査、
  `V_plus_exponential_form/`）が持つ。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_goal.sage | (1) `W P^{(+)}`（`W` は `exp((K_1/2)Σσ^zσ^z)` と成分定義の `V_2` から）と (3) の右辺 × `P^{(+)}` の相対残差が `1e-9` 以下。否定コントロール: `P^{(+)}` を外すと一致しない。(2) `QQ` で厳密に `im P^{(+)} = ker(ε − I)`（次元 `2^{M−1}`）。否定コントロール: `im P^{(-)}` は一致しない。(3) `(V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}` と右辺の相対残差が `1e-9` 以下。否定コントロール: `K_2^*` を `K_2` に替えると一致しない（`M_col ∈ {2,3,4}`、`MAXEIG_CASES` の 7 組） | PASS | 最大相対残差 8.3e-16、(2) は全組で厳密に成立、否定コントロールの残差 ≥ 0.33 |

## 備考

- **ℝ 脱出（指数評価）**: (1)(3) の行列の指数関数は成分が超越数になり、厳密計算できない。倍精度複素数 `CDF` で計算した。
  (2) の `ε` と `P^{(+)}` は成分が有理数なので `QQ` で厳密に計算した。
- (1)(3) の `P^{(+)}`（`CDF`）と (2) の `P^{(+)}`（`QQ`）が同じ行列であることも確かめている（残差 0）。

## 実行方法

```bash
cd sagemath/check/W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form
sage check_goal.sage
```

実行ログは `logs/` に保存してある（2026-10-31）。
