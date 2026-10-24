# SageMath Check: 正の根の特定（x_c = −1+s）

**対象ラベル**: `def_critical_point`, `claim_self_dual_root_plus_mem`

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
