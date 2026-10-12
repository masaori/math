# SageMath Check: 正の有理数は正錐の元である

**対象ラベル**: `claim_positive_rational_in_positive_cone`

本文の証明の各段を厳密計算で確認する。浮動小数点は使わない。

- 有理数の包含 $\iota_{\mathbb Q}:\mathbb Q\hookrightarrow\overline{\mathbb Q}$ による所属の鎖。$\iota_{\mathbb Q}(q)$ に代数的数の零を足し、零の積に直し、係数の零を $\iota_{\mathbb Q}(0_{\mathbb Q})$ と書く。
- 表示の証人 $(q,0_{\mathbb Q})$ が $\iota_{\mathbb Q}(q)$ を表すことと、表示でない組の標本。
- 正錐の第一条件（$0\le q$、$0\le0$、$(q,0)\ne(0,0)$）が $\mathbb{Q}$ の順序で成り立つこと。
- 非空虚性: $q=0$ と負の有理数は三条件のどれも満たさないこと。

$s\in\overline{\mathbb Q}$、$s\cdot s=\iota_{\mathbb Q}(2)$ の二つの解で検査する（主張は「任意の $s$」について）。

```sh
sage sagemath/check/positive-rational-in-positive-cone/check.sage
```

**2026-08-18 実行: すべて通過。**

## 包含を明示した十二行の検算

対象は同じ主張の三等号、台集合への所属、一意表示、係数の二等号、非負性二行、有理数と係数対の非零性、正錐への所属である。有理数の包含と二種類の零を明示する。正の九有理数（分子一から四、分母一から三の重複を除く）と二根の18例を各行で調べる。

表示の組は二次数体から係数を取り出して得る。これが本文の表示写像と一致することは既証の一意性による。有限標本の検算は一般の一意性や正錐への所属の証明を代替しない。既存の正の六有理数と非正の四有理数の統合検算も保つ。

| ファイル | 本文の行 | 状態 | 結果 |
|---|---|---|---|
| `check_add_zero.sage` | 代数的数の加法単位元 | PASS | 18確認 |
| `check_zero_product.sage` | 代数的数の零元の乗法 | PASS | 18確認 |
| `check_embed_zero.sage` | 包含が有理数の零を保つ | PASS | 18確認 |
| `check_field_membership.sage` | 有理係数の証人による台集合への所属 | PASS | 18確認 |
| `check_representation.sage` | 数体から取り出した表示の組 | PASS | 18確認 |
| `check_first_coefficient.sage` | 第一係数の定義 | PASS | 18確認 |
| `check_second_coefficient.sage` | 第二係数の定義 | PASS | 18確認 |
| `check_first_nonnegative.sage` | 第一係数の非負性 | PASS | 18確認 |
| `check_second_nonnegative.sage` | 第二係数の非負性 | PASS | 18確認 |
| `check_rational_nonzero.sage` | 正の有理数は零でない | PASS | 18確認 |
| `check_pair_nonzero.sage` | 係数対は零対でない | PASS | 18確認 |
| `check_positive_membership.sage` | 表示の組による正錐への所属 | PASS | 18確認 |

各行のファイルは通常の CLI でも単独実行できる。

2026-10-12 実行: 十二行216確認、既存の両根・正の六有理数と非正の四有理数の統合検算が通過。統合ファイルと全十二行別ファイルの計13本を通常の CLI で単独実行し、すべて通過した。
