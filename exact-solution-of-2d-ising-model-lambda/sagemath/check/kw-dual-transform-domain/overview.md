# SageMath Check: 双対変換の定義と、値が定義域に留まること

## 対象

**対象ラベル**: `def_kw_dual_transform`, `claim_kw_dual_transform_domain`

- 実行日: 2026-10-11
- 結果: 主張全体の 16 点と、本文の等号 14 行の各 16 点がすべて PASS
- 帰属: `QQbar`（代数的数）の厳密計算。浮動小数点は使わない。

## 何を確かめるか

双対変換 $\mathrm{KW}(\xi):=(1-\xi)\cdot(1+\xi)^{-1}$（`def_kw_dual_transform`）について、
$1+\xi\ne0$ を満たす代数的数の検査点で

- 主張 $1+\mathrm{KW}(\xi)\ne0$（`claim_kw_dual_transform_domain`）
- 証明の鎖の中間段 $1+\mathrm{KW}(\xi)=2\cdot(1+\xi)^{-1}$

を突き合わせる。検査点は有理数・無理な実代数的数（$\sqrt2$、$\sqrt2-1$ を含む）・
虚の代数的数（虚数単位、1 の 3 乗根・8 乗根）を混ぜた 16 点である。
`QQbar` の等号・非零判定は厳密（根分離）であり、数値近似を経由しない。
検査点と双対変換の定義は `_prelude.sage` で共有する。

## 各行の検算

本文の十一等号と、背理法の三等号を次の順に各ファイルで検査する。
背理法の代入行は、実際の逆元が零になる検査点を要求するのではなく、
$\overline{\mathbb Q}[r]$ の多項式の差へ $r=0$ を代入して検査する。
有限個の検算は一般の証明の代わりではなく、矛盾する仮定全体の成立を主張しない。

| ファイル | 根拠 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | 双対変換の値と非零性 | PASS | 16 点 |
| `check_dual_definition.sage` | 双対変換の定義 | PASS | 16 点 |
| `check_inverse_identity.sage` | 単位元を逆元の積へ置換 | PASS | 16 点 |
| `check_distributivity.sage` | 右分配則 | PASS | 16 点 |
| `check_subtraction_definition.sage` | 減法の定義 | PASS | 16 点 |
| `check_outer_associativity.sage` | 外側の加法の結合則 | PASS | 16 点 |
| `check_inner_associativity_left.sage` | 内側の加法の結合則を逆向きに適用 | PASS | 16 点 |
| `check_commutativity.sage` | 加法の交換則 | PASS | 16 点 |
| `check_inner_associativity_right.sage` | 内側の加法の結合則を順向きに適用 | PASS | 16 点 |
| `check_additive_inverse.sage` | 加法の逆元の取消 | PASS | 16 点 |
| `check_additive_identity.sage` | 加法の零元 | PASS | 16 点 |
| `check_two_definition.sage` | $2:=1+1$ | PASS | 16 点 |
| `check_contradiction_inverse_identity.sage` | 背理法で逆元の等式を逆向きに適用 | PASS | 16 点 |
| `check_contradiction_inverse_zero.sage` | 背理法の仮定 $r=0$ による置換 | PASS | 16 点 |
| `check_contradiction_zero_product.sage` | 背理法で零元との積を計算 | PASS | 16 点 |

## 実行方法

プロジェクト直下から実行する。`check.sage` は主張全体と各行のファイルをすべて実行する。
各行のファイルも、同じ作業ディレクトリから単独で実行できる。

```sh
sage sagemath/check/kw-dual-transform-domain/check.sage
```

上記を `/home/masaori/.local/share/math-mamba/envs/sage/bin/sage` で実行し、
すべてのファイルの `RESULT: PASS` と終了コード 0 を確認した。
