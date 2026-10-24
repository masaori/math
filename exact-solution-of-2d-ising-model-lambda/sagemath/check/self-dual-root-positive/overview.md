# SageMath Check: 正の根の特定（x_c = −1+s）

**対象ラベル**: `def_critical_point`, `claim_self_dual_root_plus_mem`, `claim_self_dual_root_plus_representation`, `claim_self_dual_root_plus_positive`

（同じ検証で `claim_self_dual_root_plus_mem`・`claim_self_dual_root_plus_representation`・
`claim_self_dual_root_minus_mem`・`claim_self_dual_root_minus_representation`・
`claim_self_dual_root_plus_positive`・`claim_self_dual_root_minus_not_positive`・
`claim_self_dual_positive_root_unique` の内容も見る。）

- 実行日: 2026-08-14
- 結果: PASS（s·s=2 を満たす 2 つの s の両方で全段を検査。表示の一意性の照合 98 組）
- 帰属: `QQ` / `QQbar` の厳密計算。浮動小数点は使わない。

## 何を確かめるか

- 根 $-1+s$ の所属と表示: $-1+s=(-1)+1\cdot s$ の鎖の各段と、表示 $(-1,1)$。
- 根 $-1-s$ の所属と表示: $-1-s=(-1)+(-1)\cdot s$ の鎖の各段と、表示 $(-1,-1)$。
- $-1+s\in P_s$: 正錐の第三条件の各比較（$a=-1<0$、$0<1=b$、
  $a\cdot a=1<2=2\cdot(b\cdot b)$。すべて `QQ` の順序）。
- $-1-s\notin P_s$: 三条件がすべて破れること（第一・第二は $0\le a$／$0<a$、第三は $0<b$ が破れる）。
- 正の根の一意性: 自己双対方程式 $\xi^2+2\xi-1=0$ の根の全体が $\{-1+s,\ -1-s\}$ で、
  正錐に属するのは $-1+s$ だけであること。
- 臨界点 $x_c:=-1+s$ が自己双対方程式を満たすこと。実数の平方根 $\sqrt2-1$ との照合は
  参考としてのみ行う（定義には使わない）。

## 根 −1+s の所属の行別検算

本文の包含写像 `ι: QQ → QQbar` をコードでは `j` と書き、両体の単位元を区別する。二次体への所属は `NumberField(z^2-2, embedding=s)` へ実際の `QQbar` の値を逆変換し、得られた数体の `{1,r}` 基底座標から元を再構成して判定する。期待する係数対を逆変換の入力に用いず、両平方根のそれぞれを埋込みに指定する。

| ファイル | 本文の行 | 状態 | 件数 |
|---|---|---|---|
| `check_plus_mem_notation.sage` | 負の一の記法 | PASS | 2 |
| `check_plus_mem_map_one.sage` | 包含の一保存 | PASS | 2 |
| `check_plus_mem_map_neg.sage` | 包含の負号保存 | PASS | 2 |
| `check_plus_mem_unit_product.sage` | 左単位元の挿入 | PASS | 2 |
| `check_plus_mem_map_one_product.sage` | 一の包含像への置換 | PASS | 2 |
| `check_plus_mem_negative_coefficient.sage` | 負の一の有理数への所属 | PASS | 2 |
| `check_plus_mem_unit_coefficient.sage` | 一の有理数への所属 | PASS | 2 |
| `check_plus_mem_coefficient_pair.sage` | 係数対の有理数対への所属 | PASS | 2 |
| `check_plus_mem_represented_membership.sage` | 表示された値の二次体への所属 | PASS | 2 |
| `check_plus_mem_root_membership.sage` | 等号による根の二次体への所属 | PASS | 2 |

プロジェクト直下から個別に実行する。

```sh
for f in sagemath/check/self-dual-root-positive/check_plus_mem_*.sage; do
  sage "$f" || exit
done
sage sagemath/check/self-dual-root-positive/check.sage
```

2026-10-24: 本文の三所属・五等号・二所属と対応する行別10本を両平方根で個別に実行して通過した。既存の `check.sage` も両根と表示一意性98組の回帰検算を通過した。

## 根 −1+s の表示の行別検算

表示の係数対は、根の `QQbar` の値を両埋込みの二次数体へ逆変換して抽出する。期待する `(-1,1)` は抽出に使わず、表示一意性の行の右辺との比較だけに使う。包含写像を `j`、二つの体の一を `one_q` と `one_k` と書く。

| ファイル | 本文の行 | 状態 | 件数 |
|---|---|---|---|
| `check_plus_rep_root_membership.sage` | 根の二次体への所属 | PASS | 2 |
| `check_plus_rep_coefficient_membership.sage` | 表示の有理数対への所属 | PASS | 2 |
| `check_plus_rep_reconstruction.sage` | 表示写像による値の復元 | PASS | 2 |
| `check_plus_rep_map_one.sage` | 包含の一保存 | PASS | 2 |
| `check_plus_rep_map_neg.sage` | 包含の負号保存 | PASS | 2 |
| `check_plus_rep_unit_product.sage` | 左単位元の挿入 | PASS | 2 |
| `check_plus_rep_map_one_product.sage` | 一の包含像への置換 | PASS | 2 |
| `check_plus_rep_unique.sage` | 表示一意性による係数対の一致 | PASS | 2 |

2026-10-24: 二所属・六等号を行別8本で両平方根について検算し、通過した。Lean の独立な具体版と必要十分版も、表示復元・包含保存・左単位元・係数一意性の同じ鎖に対応する。対応する具体版・必要十分版・導出版の Lean ビルドと、既存 `check.sage` の両根・一意性98組の回帰検算も通過した。

```sh
for f in sagemath/check/self-dual-root-positive/check_plus_rep_*.sage; do
  sage "$f" || exit
done
```

## 根 −1−s の所属の行別検算

有理数の包含と両体の一を区別し、本文の三所属・七等号・二所属をそれぞれ検査する。二次体への所属は上記の数体への逆変換による。

| ファイル | 状態 | 件数 |
|---|---|---|
| `check_minus_mem_coefficient.sage` | PASS | 2 |
| `check_minus_mem_inclusion.sage` | PASS | 2 |
| `check_minus_mem_pair.sage` | PASS | 2 |
| `check_minus_mem_notation.sage` | PASS | 2 |
| `check_minus_mem_map_one.sage` | PASS | 2 |
| `check_minus_mem_map_neg.sage` | PASS | 2 |
| `check_minus_mem_unit_product.sage` | PASS | 2 |
| `check_minus_mem_negative_product.sage` | PASS | 2 |
| `check_minus_mem_coefficient_one.sage` | PASS | 2 |
| `check_minus_mem_coefficient_neg.sage` | PASS | 2 |
| `check_minus_mem_field.sage` | PASS | 2 |
| `check_minus_mem_root.sage` | PASS | 2 |

実行日: 2026-10-24。所属の十二行を両平方根で検算し、既存の全行と統合検算（表示一意性98組）も通過した。有限検算は一般証明の代わりではない。

## 根 −1−s の表示の行別検算

表示の係数対は、根の代数的数の値を両埋込みの数体へ逆変換して取得する。期待する係数対を抽出へ与えず、最後の表示一意性の行で比較する。本文の二所属・八等号・係数対の一等号を一行一ファイルで検査する。

| ファイル | 本文の行 | 状態 | 件数 |
|---|---|---|---|
| `check_minus_rep_root_membership.sage` | 根の二次体への所属 | PASS | 2 |
| `check_minus_rep_coefficient_membership.sage` | 表示の有理数対への所属 | PASS | 2 |
| `check_minus_rep_reconstruction.sage` | 表示写像による値の復元 | PASS | 2 |
| `check_minus_rep_notation.sage` | 減法の記法 | PASS | 2 |
| `check_minus_rep_map_one.sage` | 包含の一保存 | PASS | 2 |
| `check_minus_rep_map_neg.sage` | 包含の負号保存 | PASS | 2 |
| `check_minus_rep_unit_product.sage` | 左単位元の挿入 | PASS | 2 |
| `check_minus_rep_negative_product.sage` | 積の加法逆元 | PASS | 2 |
| `check_minus_rep_coefficient_one.sage` | 係数の一の包含像への置換 | PASS | 2 |
| `check_minus_rep_coefficient_neg.sage` | 係数の負号保存 | PASS | 2 |
| `check_minus_rep_unique.sage` | 表示一意性による係数対の一致 | PASS | 2 |

2026-10-24: 行別11本を両平方根で検算して通過した。既存の行別30本と統合検算（表示一意性98組）も通過した。有限検算は一般証明の代わりではない。

実行コマンド（プロジェクト直下から実行し、SageMath の `load` 前に入力ファイルの `__file__` を明示する）:

```sh
micromamba run -n sage sage -c 'from pathlib import Path
for p in sorted(Path("sagemath/check/self-dual-root-positive").glob("check*.sage")):
    __file__ = str(p.resolve())
    load(__file__)'
```

## 根 −1+s は正であることの行別検算

根の値を各平方根の埋込みを持つ二次数体へ逆変換し、表示対を独立に取り出す。本文の三所属、符号の二鎖、平方の比較鎖、正錐の第三条件を一行一ファイルで検査する。順序の比較はすべて有理数上で行い、代数的数の実数順序へ置き換えない。

| ファイル | 本文の行 | 状態 | 件数 |
|---|---|---|---|
| `check_plus_positive_root_membership.sage` | 根の二次体への所属 | PASS | 2 |
| `check_plus_positive_representation_membership.sage` | 表示対の有理数対への所属 | PASS | 2 |
| `check_plus_positive_coefficient_membership.sage` | 各係数の有理数への所属 | PASS | 2 |
| `check_plus_positive_negative_coefficient.sage` | 第一係数の表示 | PASS | 2 |
| `check_plus_positive_negative_comparison.sage` | 負の一と零の比較 | PASS | 2 |
| `check_plus_positive_positive_comparison.sage` | 零と一の比較 | PASS | 2 |
| `check_plus_positive_positive_coefficient.sage` | 第二係数の表示 | PASS | 2 |
| `check_plus_positive_square_substitution.sage` | 第一係数の平方への代入 | PASS | 2 |
| `check_plus_positive_square_sign.sage` | 二つの負号の積 | PASS | 2 |
| `check_plus_positive_square_unit.sage` | 一の平方の整理 | PASS | 2 |
| `check_plus_positive_square_comparison.sage` | 一と二の比較 | PASS | 2 |
| `check_plus_positive_double_unit.sage` | 二に右単位元を挿入 | PASS | 2 |
| `check_plus_positive_double_square_unit.sage` | 一の平方を挿入 | PASS | 2 |
| `check_plus_positive_double_substitution.sage` | 第二係数の平方への置換 | PASS | 2 |
| `check_plus_positive_double_associativity.sage` | 積の結合律 | PASS | 2 |
| `check_plus_positive_cone_membership.sage` | 正錐の第三条件による所属 | PASS | 2 |

2026-10-24: 新規16本を両平方根で検算して通過した。既存41本の行別検算と統合検算（表示一意性98組）を含む計58本も通過した。

実行方法は上記の `check*.sage` 一括実行と同じ。有限検算は一般証明の代わりではない。

## 根 −1−s は正でないことの行別検算

両平方根の埋込みで根を数体へ逆変換し、期待する係数対を入力せずに表示を抽出する。本文の三所属・二つの符号の鎖・三比較の否定・三条件の否定・非所属を検査する。順序比較は有理数上に限る。

| ファイル | 本文の行 | 状態 | 件数 |
|---|---|---|---|
| `check_minus_not_positive_root_membership.sage` | 根の二次体への所属 | PASS | 2 |
| `check_minus_not_positive_representation_membership.sage` | 表示対の有理数対への所属 | PASS | 2 |
| `check_minus_not_positive_coefficient_membership.sage` | 両係数の有理数への所属 | PASS | 2 |
| `check_minus_not_positive_first_coefficient.sage` | 第一係数の表示 | PASS | 2 |
| `check_minus_not_positive_first_negative.sage` | 第一係数の負値性 | PASS | 2 |
| `check_minus_not_positive_second_coefficient.sage` | 第二係数の表示 | PASS | 2 |
| `check_minus_not_positive_second_negative.sage` | 第二係数の負値性 | PASS | 2 |
| `check_minus_not_positive_first_not_nonnegative.sage` | 第一係数の非負性の否定 | PASS | 2 |
| `check_minus_not_positive_first_not_positive.sage` | 第一係数の正値性の否定 | PASS | 2 |
| `check_minus_not_positive_second_not_positive.sage` | 第二係数の正値性の否定 | PASS | 2 |
| `check_minus_not_positive_first_condition.sage` | 正錐の第一条件の否定 | PASS | 2 |
| `check_minus_not_positive_second_condition.sage` | 正錐の第二条件の否定 | PASS | 2 |
| `check_minus_not_positive_third_condition.sage` | 正錐の第三条件の否定 | PASS | 2 |
| `check_minus_not_positive_cone_nonmembership.sage` | 正錐への非所属 | PASS | 2 |

初回実行は表示対の検算で未定義の `CartesianProduct` を呼んで停止した。既存と同じ `cartesian_product([QQ, QQ])` に直し、所属の検査内容を保って全対象を再実行した。

2026-10-24: 新規14本を両平方根で検算し、28件すべて通過した。既存58本を含む全72本も通過し、統合検算の表示一意性98組を確認した。対応する Lean 具体版・必要十分版・導出版のビルドも通過した。有限検算は一般証明の代わりではない。
