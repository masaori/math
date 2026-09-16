# SageMath Check: 第二双対結合関係

## 対象

**対象ラベル**: `second_dual_coupling_relation` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`（ブロック `transfer_matrix_000l_claim_second_dual_coupling_relation`）
- 範囲: 双対結合定数の定義から `sinh(2K_2)sinh(2K_2^*)=1` までの全等号
- 併せて検証: 双曲線正弦の倍角公式を定義から導く等号列

## チェック一覧

各 `check_*.sage` は人手証明の連続する一組の等式だけを照合する。

| 検査範囲 | ファイル数 | ステータス | 結果 |
|---|---:|---|---|
| 双対結合定数の定義と指数関数への変換 | 12 | PASS | すべて相対誤差 `2^-150` 以下 |
| `sinh(2K_2^*)` の導出 | 4 | PASS | すべて相対誤差 `2^-150` 以下 |
| 倍角公式の定義からの導出 | 5 | PASS | すべて相対誤差 `2^-150` 以下 |
| 双対積を `1` へ変形する等号列 | 8 | PASS | すべて相対誤差 `2^-150` 以下 |

合計 29 ファイルを実行し、最大相対誤差は
`1.8855736291919259372646514082953776448988464071225136413295e-58` だった。

## 備考

- $K_2,K_2^*$、双曲線関数、実指数関数、実対数は $\mathbb{R}$ に属する。
- 実対数を使うため、この検査は「実対数による $\mathbb{R}$ 脱出」後の数値検査である。200 bit の `RealField` を使い、相対誤差 `2^-150` 以下を PASS とする。
- 各分母は本文どおり $K_2>0$ から $\sinh K_2\ne0$、$\cosh K_2\ne0$、$\tanh K_2\ne0$ を得る範囲だけで評価する。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh second_dual_coupling_relation
```
