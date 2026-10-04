# SageMath Check: 双対変換の定義と、値が定義域に留まること

## 対象

**対象ラベル**: `def_kw_dual_transform`, `claim_kw_dual_transform_domain`

- 実行日: 2026-10-04
- 結果: 既存の検査点 16 点と、分割した等号 8 行の各 16 点がすべて PASS
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

本文で分配則を適用した後の計算を、次の順に各ファイルで検査する。

| ファイル | 根拠 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | 双対変換の値と非零性 | PASS | 16 点 |
| `check_subtraction_definition.sage` | 減法の定義 | PASS | 16 点 |
| `check_outer_associativity.sage` | 外側の加法の結合則 | PASS | 16 点 |
| `check_inner_associativity_left.sage` | 内側の加法の結合則を逆向きに適用 | PASS | 16 点 |
| `check_commutativity.sage` | 加法の交換則 | PASS | 16 点 |
| `check_inner_associativity_right.sage` | 内側の加法の結合則を順向きに適用 | PASS | 16 点 |
| `check_additive_inverse.sage` | 加法の逆元の取消 | PASS | 16 点 |
| `check_additive_identity.sage` | 加法の零元 | PASS | 16 点 |
| `check_two_definition.sage` | $2:=1+1$ | PASS | 16 点 |

## 実行方法

プロジェクト直下から次のように実行する。各ファイルはプロジェクト直下からパスを指定して実行する形にも対応する。

```sh
cd sagemath/check/kw-dual-transform-domain
sage -c 'from pathlib import Path; load("check.sage"); [load(str(path)) for path in sorted(Path(".").glob("check_*.sage"))]'
```

上記を `/home/masaori/.local/share/math-mamba/envs/sage/bin/sage` で実行し、
すべてのファイルの `RESULT: PASS` と終了コード 0 を確認した。
