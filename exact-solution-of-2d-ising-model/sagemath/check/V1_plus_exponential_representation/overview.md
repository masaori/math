# SageMath Check: 第一転送行列 V_1^{(+)} の一般生成子による指数表示

## 対象

**対象ラベル**: `V1_plus_exponential_representation` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`（ブロック `transfer_matrix_011c_claim_V1_pm_exponential_representation`）
- 範囲: `def_V1_plus` の指数の中の有限和 `Σ_{m=1}^{M_col-1} Y_mZ_{m+1} − Y_{M_col}Z_1` を
  `def_H1_plus` の `H_1^{(+)}` へ置換する証明行

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_generator_substitution.sage` | `2 ≤ M_col ≤ 6` で有限和と `H_1^{(+)}` および指数の肩 `iK_1(…)` が一致すること | PASS | 全条件で厳密等号が成立 |

## 備考

- 行列成分を `QQ(i)` に置き、等号を厳密に判定する。浮動小数点と ℝ 脱出は用いない。
- 行列指数関数の引数が等しいことを検査する。関数へ等しい引数を入れた値が等しいことは等号の合同性による。
  `K_1 ∈ ℝ_{>0}` は記号のまま扱わず、有理数の代表値 `K_1 = 1, 2/5` で肩の一致を確かめている。
- 旧ラベル `V1_pm_exponential_representation`（両符号 `V_1^{(±)}` の主張）の検査は、
  (−) セクターを本文から外したときに `sagemath/_old/minus-sector/V1_pm_exponential_representation/`
  へ移した。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh V1_plus_exponential_representation
```

実行ログは `sagemath/check/V1_plus_exponential_representation/logs/` に保存してある。
