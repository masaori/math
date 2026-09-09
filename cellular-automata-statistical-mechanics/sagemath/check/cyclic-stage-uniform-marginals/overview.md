# SageMath 検算: 奇数位数の有限巡回舞台上の一様有理分布と周辺化整合性

## 対象

**対象ラベル**: `theorem_cyclic_stage_uniform_marginals_consistent`

- 併せて検証するラベル: `claim_cyclic_stage_uniform_distribution_normalized`、
  `claim_cyclic_stage_window_embeddings_compatible`、`claim_cyclic_stage_uniform_marginal_formula`。
- 奇数位数の有限巡回舞台への窓埋め込み、その引き戻しの整合性、各繊維の元数、
  一様有理分布の有限窓周辺確率、窓の包含に沿う再周辺化を本文の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_embedding_compatibility.sage` | 有限窓埋め込みの単射性と包含整合性、および配位の引き戻しの制限 | PASS | `0 <= s <= t <= m <= 6` の 84 組、全 281,562 配位引き戻しで一致 |
| `check_fiber_cardinality.sage` | 有限窓引き戻しの各繊維の元数 `2^(2(m-s))` | PASS | `0 <= s <= m <= 6` の全 14,558 繊維、延べ 72,818 配位走査で一致 |
| `check_marginal_formula.sage` | 一様有限舞台分布の正規化と有限窓周辺確率 `1/2^(2s+1)` | PASS | 7 舞台の正規化と全 14,558 周辺確率で一致 |
| `check_remarginalization_consistency.sage` | 大窓の全延長にわたる周辺確率の有限和と小窓周辺確率の一致 | PASS | `0 <= s <= t <= m <= 5` の全 4,834 等式、19,420 延長で一致 |

## 範囲と限界

- 舞台添字は埋め込み・繊維・周辺確率では `0..6`、再周辺化では `0..5` を全数検査する。
  各範囲内で半径条件を満たす全窓、全有限配位、全窓配位を列挙する。
- これは明記した有限範囲のプログラミングによる検証であり、任意の自然数添字についての一般証明ではない。
  一般の場合の根拠は構造化記述の証明にある。
- 一様分布は局所規則や遷移核から導いていない。Gibbs 仕様、DLR 条件、Gibbs 測度との対応、
  数学的な近似は検算しない。
- 全て有限集合、`ZZ`、`QQ`、有限和で厳密に検査する。除算は正の二冪を分母とする有理数内だけで行う。
  対数、浮動小数点、全配位の逆極限、極限、実数体、複素数体は使わない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/cyclic-stage-uniform-marginals/check_*.sage; do sage "$file"; done
```
