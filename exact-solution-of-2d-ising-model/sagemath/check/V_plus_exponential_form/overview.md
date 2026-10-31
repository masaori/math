# SageMath Check: V_plus_exponential_form

## 対象

**対象ラベル**: `V_plus_exponential_form` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`
  （ブロック `projection_and_jordan_wigner_claim_V_plus_exponential_form`）
- 主張: `M_col ≥ 2`、`K_1, K_2 > 0` のとき
  `V^{(+)} = exp((i/2)K_1H_1^{(+)}) (2 sinh 2K_2)^{M_col/2} exp(iK_2^*H_2) exp((i/2)K_1H_1^{(+)})`
- 範囲: proof の式変形 4 行（`def_V_plus`、`def_V1_plus_square_root`、`V2_exponential_representation`、
  `def_indexed_hyperbolic_abbreviations` の代入）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_chain.sage | 0 行目 `V^{(+)}` から 4 行目の右辺までの 5 つの値を各行の式どおりに独立に作り、隣どうしの相対残差（作用素ノルム）が `1e-9` 以下であること。否定コントロール（4 行目で `K_2^*` の代わりに `K_2`）は 0 行目と一致しないこと（`M_col ∈ {2,3,4}`、`044_claim_max_eigenvalue` の `MAXEIG_CASES` の 7 組） | PASS | 最大相対残差 2.5e-16、否定コントロールの残差 ≥ 0.40 |

## 備考

- **ℝ 脱出（指数評価）**: `exp((i/2)K_1H_1^{(+)})` と `exp(iK_2^*H_2)` は成分が超越数になり、厳密計算できない。
  倍精度複素数 `CDF` で計算した。
- 0 行目の `V^{(+)}` は `043_claim_transfer_matrix_bridge/_prelude.sage` の `V_plus`（`V_2` はパウリ行列表示）で作り、
  1〜2 行目の `V_2` は成分定義（`def_transfer_matrix`、`V2_component`）から作る。0 行目と 1 行目の比較は、
  二つの作り方の `V_2` が一致することも確かめている。
- この式変形は、参照用ノートへ退避した `symmetrized_transfer_matrix_on_sector_exponential_form` の証明の 2〜5 行目から
  右の `P^{(+)}` を除いたものである（その検査は `sagemath/_old/symmetrized-transfer-matrix-on-sector-exponential-form/`）。

## 実行方法

```bash
cd sagemath/check/V_plus_exponential_form
sage check_chain.sage
```

実行ログは `logs/` に保存してある（2026-10-31）。
