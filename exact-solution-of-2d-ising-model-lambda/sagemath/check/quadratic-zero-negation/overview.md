# SageMath Check: 二次体の零元の特徴づけと加法逆元の表示

## 対象

**対象ラベル**: `claim_quadratic_zero_mem`、`claim_quadratic_zero_representation`、
`claim_quadratic_negation_mem`、`claim_quadratic_negation_representation`

- 実行日: 2026-08-13
- 結果: 通過（加法逆元の両立 19 組、零元の特徴づけ 722 組、
  加法逆元の表示の鎖 722 組を厳密検査した）
- 帰属: `QQ` / `QQbar` の厳密計算。浮動小数点は使わない。

## 零元の所属の行別検算

対象は `claim_quadratic_zero_mem` の四等号と、最後の所属の証人である。
包含 $\iota:\mathbb Q\hookrightarrow\overline{\mathbb Q}$ を明示し、有理数の零を左右一回ずつ移す。
各ファイルは $s^2=2$ の二根をそれぞれ検算し、既存の四主張の検算も保つ。

| ファイル | 対象 | ステータス | 結果 |
|---|---|---|---|
| `check_zero_add.sage` | $0=0+0$ | PASS | 二根、2等式 |
| `check_zero_mul.sage` | $0+0=0+0s$ | PASS | 二根、2等式 |
| `check_zero_left_embedding.sage` | 左の加数を $\iota(0_{\mathbb Q})$ へ移す | PASS | 二根、2等式 |
| `check_zero_right_embedding.sage` | 右の係数を $\iota(0_{\mathbb Q})$ へ移す | PASS | 二根、2等式 |
| `check_zero_membership_witness.sage` | $(0_{\mathbb Q},0_{\mathbb Q})$ が零の表示を与える | PASS | 二根、2例 |

2026-10-05 実行: 四等号の計8等式と所属の証人2例が通過した。
既存の加法逆元の両立19組、零元の特徴づけ722組、加法逆元の表示の鎖722組も通過した。
この有限検算は一般の $s$ の証明ではなく、本文と Lean の各行に対する厳密な裏取りである。

## 何を確かめるか

四主張は「$0\in Q_s$」「$\xi=0\iff\mathrm{rep}_s(\xi)=(0,0)$」
「$-\xi\in Q_s$」「$\mathrm{rep}_s(-\xi)=(-a,-b)$」である。

- **zero-chain**: 準備の鎖 $0=0+0=0+0\cdot s$ の各段が `QQbar` の厳密等号で成り立つ。
- **zero-iff**: 標本の全組（分子 $-4..4$、分母 $1..3$ の有理数の組、$s$ の 2 根）で
  「$a+b\cdot s=0\iff(a,b)=(0,0)$」が成り立つ。第一の方向は表示の一意性の適用、
  第二の方向は本文の第二の方向の鎖の裏取りである。
- **neg-compat**: $\mathbb{Q}$ の加法逆元と $\overline{\mathbb{Q}}$ の加法逆元の一致
  （準備の段の裏取り）。
- **neg-chain / neg-rep**: 本文の鎖 $-(a+b\cdot s)=(-a)+(-(b\cdot s))=(-a)+(-b)\cdot s$ を
  一段ずつ `QQbar` の厳密等号で確かめる。表示の一意性
  （`claim_quadratic_representation_unique`。別の検証で裏取り済み）のもとで、
  終点の表示 $(-a,-b)$ がそのまま $\mathrm{rep}_s(-\xi)=(-a,-b)$ を与える。

## 実行方法

```sh
sage -c "__file__ = 'sagemath/check/quadratic-zero-negation/check.sage'; load(__file__)"
```

プロジェクト直下から実行する。

## 零元の表示の特徴づけの行別検算

対象は `claim_quadratic_zero_representation` の十四等号である。
第一方向の六等号、係数の組の二等号、逆方向の六等号をそれぞれ一ファイルで検算する。
二次体の二係数を取り出して二つの埋込みにより `QQbar` の値を求める。
この係数の組と本文の表示写像との一致は、本文で既に証明した表示の一意性による。
分子が $-4$ から $4$、分母が $1$ から $3$ の十九有理数から作る組を用いる。
両方向の表示の仕様と組の定義は各二根・722表示で調べる。
仮定を使う残りの各行は、零となる二根・2表示に限定する。

| ファイル | 対象 | ステータス | 結果 |
|---|---|---|---|
| `check_zero_representation_forward_specification.sage` | 表示写像の仕様 | PASS | 722等式 |
| `check_zero_representation_forward_zero_hypothesis.sage` | 元が零という仮定 | PASS | 2等式 |
| `check_zero_representation_forward_add_zero.sage` | 加法の単位元 | PASS | 2等式 |
| `check_zero_representation_forward_zero_product.sage` | 零との積 | PASS | 2等式 |
| `check_zero_representation_forward_left_embedding.sage` | 左の加数の包含 | PASS | 2等式 |
| `check_zero_representation_forward_right_embedding.sage` | 右の係数の包含 | PASS | 2等式 |
| `check_zero_representation_pair_definition.sage` | 二係数の定義 | PASS | 722等式 |
| `check_zero_representation_pair_uniqueness.sage` | 表示の一意性 | PASS | 2等式 |
| `check_zero_representation_reverse_specification.sage` | 表示写像の仕様 | PASS | 722等式 |
| `check_zero_representation_reverse_pair_hypothesis.sage` | 組が零という仮定 | PASS | 2等式 |
| `check_zero_representation_reverse_left_embedding.sage` | 左の加数の包含 | PASS | 2等式 |
| `check_zero_representation_reverse_right_embedding.sage` | 右の係数の包含 | PASS | 2等式 |
| `check_zero_representation_reverse_zero_product.sage` | 零との積 | PASS | 2等式 |
| `check_zero_representation_reverse_add_zero.sage` | 加法の単位元 | PASS | 2等式 |

2026-10-05 実行: 十四行の計2188等式が通過した。
既存の零元の所属の8等式と2例、加法逆元の両立19組、
零元の特徴づけ722組、加法逆元の表示の鎖722組も通過した。
有限標本の検算は一般の一意性の証明を代替しない。
