# SageMath 検算: 共役類の集合と写像符号の像の全単射

## 対象

**対象ラベル**: `claim_conjugacy_class_code_image_bijection`

- 併せて検証するラベル: `def_conjugacy_class_all_global_maps`、`def_conjugacy_class_relation`、`claim_conjugacy_class_relation_is_equivalence`、`def_conjugacy_class_quotient`、`def_conjugacy_class_code_image`、`claim_conjugacy_class_count_finite_decidability`
- 元数 1・2・4 の配位集合、すなわちセル数 0・1・2 の固定舞台上の全自己写像 261 個を検査する。
- 全写像表、有限置換、再帰的前像木符号をそれぞれ有限列挙し、浮動小数点を使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_all_global_maps.sage` | 全写像の個数と、全近傍の局所真理値表による大域写像の再現 | PASS |
| `check_conjugacy_equivalence.sage` | 共役関係の反射律・対称律・推移律と共役類による分割 | PASS |
| `check_quotient_code_bijection.sage` | 商から符号の像への対応の代表非依存性・単射性・全射性 | PASS |
| `check_class_count_finite_decidability.sage` | 共役類数と相異なる写像符号数の一致、および有限列挙 | PASS |

## 限界と帰属

- 元数 1・2・4 の全自己写像については全数検査だが、任意の有限舞台に対する一般証明ではない。一般の場合の根拠は構造化記述である。
- 共役類は有限置換の全数走査、写像符号は既存の厳密な有限再帰で独立に計算する。
- 有限集合、自然数、有限写像表、有限置換、有限列・有限集合・有限多重集合の等号だけを使う。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/conjugacy-class-code-image-bijection/check_*.sage; do sage "$file"; done
```
