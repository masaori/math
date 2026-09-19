# SageMath Check: 第二転送行列の一般生成子による指数表示

## 対象

**対象ラベル**: `V2_exponential_representation` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`（ブロック `transfer_matrix_011d_claim_V2_exponential_representation`）
- 範囲: `V2_in_Z_Y` の有限和を `def_H2` の `H_2` へ置換する証明行

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_generator_substitution.sage` | `1 ≤ M ≤ 5` で有限和と `H_2` および指数の肩が一致すること | PASS | 全条件で厳密等号が成立 |

## 備考

- 行列成分を `QQ(i)` に置き、等号を厳密に判定する。浮動小数点と ℝ 脱出は用いない。
- 共通の正規化因子は両辺で同じなので、行列指数関数の引数が等しいことを検査する。関数へ等しい引数を入れた値が等しいことは等号の合同性による。

## 実行方法

```bash
sage sagemath/check/V2_exponential_representation/check_generator_substitution.sage
```
