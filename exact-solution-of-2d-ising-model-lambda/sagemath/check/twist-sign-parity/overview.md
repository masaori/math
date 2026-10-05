# ねじれ符号はねじれ偶奇で決まる

**対象ラベル**: `claim_twist_sign_from_parity`。定義は `def_spin_structures`、`def_seam_parities`、`def_twist_parity`。

辺長一から五の全向き付き辺・四ねじれの880組について、辺番号から切断線を求め、各切断線で符号を反転する構成と自然数指数による冪を比較する。
別に自然数指数0から257の258例を取り、商が正の場合も整数の厳密計算で検算する。この補助例は格子上の辺の例とは数えない。
一般の辺長に対する証明は本文と Lean が担い、有限検算から一般化しない。

| ファイル | 本文の等号 | ステータス | 検査数 |
|---|---|---|---:|
| `check_sign_definition.sage` | ねじれ符号の定義 | PASS | 1,138 |
| `check_division_exponent.sage` | 自然数の商と余り | PASS | 1,138 |
| `check_power_add.sage` | 冪の加法則 | PASS | 1,138 |
| `check_power_mul.sage` | 冪の乗法則 | PASS | 1,138 |
| `check_negative_one_square.sage` | 負の一の二乗 | PASS | 1,138 |
| `check_one_power.sage` | 一の自然数冪 | PASS | 1,138 |
| `check_one_mul.sage` | 単位元との積 | PASS | 1,138 |
| `check_parity_definition.sage` | ねじれ偶奇の定義 | PASS | 1,138 |

`check.sage` は所属と例数を確認し、八つの行別検算を本文の順に実行する。

実行方法（プロジェクト直下）:

```sh
/home/masaori/.local/share/math-mamba/envs/sage/bin/sage -c "__file__ = 'sagemath/check/twist-sign-parity/check.sage'; load(__file__)"
```

2026-10-05 実行: 所属・例数の検査と、行別八本・計9,104等式がすべて通過した。
