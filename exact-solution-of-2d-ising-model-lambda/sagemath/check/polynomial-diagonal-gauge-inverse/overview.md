# 定数多項式への対角変換の両側逆の移送

**対象ラベル**: `claim_polynomial_diagonal_gauge_inverse`。定義は `def_polynomial_diagonal_gauge`。

係数は円分体 $\mathbb Q(\zeta_8)$、移送先はその一変数多項式環であり、浮動小数点も変数への数値代入も使わない。
$L=1,2,3$、四ねじれ、四乗が $-1$ である四根の48行列を、先行する対角変換の厳密構成から作る。
両方向の行列積は全成分を調べ、独立な多項式行列の逆行列計算とも比較する。
有限和の帰納段階は、辺の列挙順の各接頭集合と、その次の一辺で調べる。係数には根の冪と整数の和を使う。
これは有限例の厳密検算であり、任意の辺長・有限集合についての証明は本文と Lean が担う。

| ファイル | 本文の等号 | ステータス | 検査数 |
|---|---|---|---:|
| `check.sage` | 両側逆と独立な逆行列計算 | PASS | 48行列 |
| `check_empty_sum_source.sage` | 空和の定義を係数の体で開く | PASS | 48 |
| `check_empty_sum_zero.sage` | 定数埋込みは零を保つ | PASS | 48 |
| `check_empty_sum_target.sage` | 多項式環の空和へ戻す | PASS | 48 |
| `check_insert_sum_source.sage` | 新しい一項を有限和から取り出す | PASS | 896 |
| `check_insert_sum_add.sage` | 定数埋込みは二項の和を保つ | PASS | 896 |
| `check_insert_sum_induction.sage` | 小さい有限集合の和を移す | PASS | 896 |
| `check_insert_sum_target.sage` | 多項式の有限和へ戻す | PASS | 896 |
| `check_identity_diagonal_source.sage` | 係数の単位行列の対角成分 | PASS | 896 |
| `check_identity_diagonal_one.sage` | 定数埋込みは一を保つ | PASS | 896 |
| `check_identity_diagonal_target.sage` | 多項式の単位行列の対角成分 | PASS | 896 |
| `check_identity_off_diagonal_source.sage` | 係数の単位行列の非対角成分 | PASS | 24,192 |
| `check_identity_off_diagonal_zero.sage` | 定数埋込みは零を保つ | PASS | 24,192 |
| `check_identity_off_diagonal_target.sage` | 多項式の単位行列の非対角成分 | PASS | 24,192 |
| `check_matrix_product_definition.sage` | 多項式行列の積を有限和へ開く | PASS | 50,176 |
| `check_matrix_entries.sage` | 定数多項式の成分を代入する | PASS | 50,176 |
| `check_matrix_product_map.sage` | 各項で積の保存を使う | PASS | 50,176 |
| `check_matrix_sum_map.sage` | 有限和の保存を使う | PASS | 50,176 |
| `check_matrix_source_product.sage` | 係数の行列積へ戻す | PASS | 50,176 |
| `check_matrix_source_inverse.sage` | 係数の両側逆の等式を使う | PASS | 50,176 |
| `check_matrix_identity_map.sage` | 単位行列の成分を移す | PASS | 50,176 |

実行方法（プロジェクト直下）:

```sh
sage -c "__file__ = 'sagemath/check/polynomial-diagonal-gauge-inverse/check.sage'; load(__file__)"
```

2026-10-04 実行: 行別20本・計430,224等式と、48行列の独立な逆行列比較が通過した。
