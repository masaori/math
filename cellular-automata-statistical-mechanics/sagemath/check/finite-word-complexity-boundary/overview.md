# SageMath 検算: 有限語個数と位相的エントロピーの境界

## 対象

**対象ラベル**: `remark_finite_word_count_entropy_boundary`

- 併せて検証するラベル: `def_finite_two_symbol_word_set`、
  `claim_finite_two_symbol_word_set_cardinality`、
  `def_forbidden_one_run_word_family`、
  `claim_forbidden_one_run_words_full_below_cutoff`、
  `claim_finite_word_counts_do_not_determine_next_length`。
- 有限二元語の生成、禁制条件、禁制長以下の個数表の一致、次の長さでの分岐を、
  本文の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_word_generation_and_forbidden_condition.sage` | 有限二元語を全生成し、本文の量化条件が連続した一の禁制と一致する | PASS | 禁制長一から八、語長一から九の全 8,176 語で成立 |
| `check_below_cutoff_agreement.sage` | 禁制長以下では全二元語が許され、個数が二の長さ乗になる | PASS | 禁制長一から十二、78 個の語長、全 16,356 語で成立 |
| `check_next_length_divergence.sage` | 次の長さでは全一語だけが除かれ、二語族の個数が一だけ分かれる | PASS | 禁制長一から十二、共有表 78 項、次段階の全 16,380 語で成立 |

## 範囲と限界

- 明示した有限範囲のプログラミングによる検証であり、任意の正の禁制長に対する一般証明ではない。
  一般証明は構造化記述にある。
- 全て有限集合と `ZZ` の加法・冪・等号比較だけで厳密に検査する。
- 無限舞台の全配位、実対数、極限、位相的エントロピー、実数体、複素数体は
  定義も検査もしていない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/finite-word-complexity-boundary/check_*.sage; do sage "$file"; done
```
