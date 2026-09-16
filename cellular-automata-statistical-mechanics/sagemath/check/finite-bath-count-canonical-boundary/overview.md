# SageMath 検算: 有限状態数比と実数指数カノニカル分布の境界

## 対象

**対象ラベル**: `claim_binary_finite_bath_count_not_always_exponential_canonical`

- 併せて検証するラベル: `claim_binary_finite_total_shell_cardinality`、
  `claim_binary_finite_bath_count_distribution_is_marginal`、
  `claim_binary_finite_positive_bath_count_exponential_comparison`。
- 有限殻の第一成分ごとの繊維分解、有理周辺分布と正規化、正の台における実対数・実指数の
  逆写像性適用後の指数分布との一致、零重みを持つ一セル反例を段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_shell_cardinality.sage` | 有限殻の元数と第二配位側の多重度の有限和 | PASS | 43,245 系・160,425 繊維で成立 |
| `check_marginal_normalization.sage` | 状態数比と一様殻分布の第一周辺分布の一致、および有理正規化 | PASS | 33,145 正殻・125,313 成分で成立 |
| `check_positive_support_exponential_comparison.sage` | 正の多重度で、実対数・実指数の逆写像性適用後に指数分布と状態数比分布が一致 | PASS | 3,905 正多重度表・18,555 成分で成立 |
| `check_zero_support_counterexample.sage` | 一セル有限反例の殻、多重度、零成分と指数形の正値域の非対応 | PASS | 殻 2 元・零成分 1 個を確認 |

## 範囲と限界

- 殻と周辺分布は、両セル数 0..2、観測値 -1..1 の全観測表、全観測和 -2..2 を検査する。
  これは明示した有限範囲のプログラミングによる検証であり、一般証明は構造化記述にある。
- 正の台の比較は、状態数 1..5、各多重度 1..5 の全正値ベクトルについて、実対数と実指数の
  逆写像性を適用した後の有限和と除算を有理数上で厳密に検査する。
- 実数脱出は、本文で自然数値多重度を実数へ送り、実対数と実指数関数を適用する箇所にある。
  本検算はその解析的構成を浮動小数点で近似せず、逆写像性適用後の有限代数段を検査する。
- 零重み反例では状態数比分布の零成分を厳密計算し、有限実数値指数形の全成分が正であるという
  本文の定義域・値域と比較する。零の対数、無限和、極限、完備化、複素数体は扱わない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/finite-bath-count-canonical-boundary/check_*.sage; do sage "$file"; done
```
