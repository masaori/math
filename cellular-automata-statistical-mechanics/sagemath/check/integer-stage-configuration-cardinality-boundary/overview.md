# SageMath 検算: 整数舞台上の有限台配位と全配位の濃度境界

## 対象

**対象ラベル**: `claim_integer_stage_finite_support_configurations_countable`

- 併せて検証するラベル: `claim_integer_stage_full_configurations_uncountable`、
  `def_integer_stage_finite_support_configurations`、`def_negation_map`。
- 有限整数窓に台を持つ二値配位の元数と、自然数添字の候補列を対角反転で外す機構を、
  本文の二つの主張に分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_finite_support_window_cardinality.sage` | 一状態台への符号化の単射性と有限窓ごとの有限台配位の元数 | PASS | 半径 0..8 の全 174,762 配位で一状態台が全て異なり、`2^(2k+1)` と一致 |
| `check_diagonal_prefix_nonmembership.sage` | 候補列の有限接頭辞に対する対角配位の非一致 | PASS | 長さ 1..4 の全 66,066 候補列について 263,714 個の行非一致を確認 |

## 範囲と限界

- 有限台配位は半径 0..8 の各整数窓について全状態表を列挙し、各配位の一状態台が全て異なることと、
  一状態台の個数が `2^(2k+1)` に一致することを検査する。
- 対角反転は長さ 1..4 の候補列について、各候補を同じ長さの二値行として全数列挙する。
  対角配位が候補番号の成分でその候補と異なることを一行ずつ検査する。
- これは明記した有限範囲のプログラミングによる検証であり、一状態台への符号化の一般的な単射性または
  全配位集合の非可算性の一般証明ではない。一般の場合の根拠は構造化記述の証明にある。
  有限集合・整数・自然数だけを使い、浮動小数点、対数、除算、実数体、複素数体、位相、測度、極限は使わない。

## 実行方法

```bash
for file in sagemath/check/integer-stage-configuration-cardinality-boundary/check_*.sage; do sage "$file"; done
```
