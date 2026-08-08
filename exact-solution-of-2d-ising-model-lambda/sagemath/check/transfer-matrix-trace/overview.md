# SageMath Check: 分配多項式は転送行列の冪のトレースである

## 対象

**対象ラベル**: `claim_closed_walk_bijection` / `theorem_partition_polynomial_is_trace`
（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「転送行列」の主張
  「行配位の族全体と閉じた道全体は 1 対 1 に対応する」と定理
  「分配多項式は転送行列の冪のトレースである」
- 併せて使う定義: `def_row_family` / `def_rows_map` / `def_matrix_over_row_configs` /
  `def_transfer_matrix` / `def_row_walk` / `def_walk_weight` / `def_closed_walk` /
  `def_walk_of_family` / `def_partition_polynomial`

### 何を確定させるための検証か

1. `def_walk_of_family`。$\Theta(c)$ が長さ $L$ の道であり、両端が一致すること
   （$\Theta$ の値が本当に閉じた道の集合に入っていること）。
2. `claim_closed_walk_bijection`。$\Xi\circ\Theta$ と $\Theta\circ\Xi$ がともに恒等写像であること、
   および $\Theta$ の像が重複なく閉じた道の全体を尽くすこと（個数が $(2^L)^L$ であることも見る）。
3. 本文の証明の「準備 1」。閉じた道の全体が、両端の値 $\tau$ ごとの $W_{L,L}(\tau,\tau)$ の
   互いに素な合併であること（各類が閉じた道に含まれること・互いに素であること・合併が全体であること）。
4. 本文の証明の「準備 2」。族から作った閉じた道の重みが $x^{b(\sigma)}$ に等しいこと。
   左辺は転送行列の成分を道に沿って掛けて作り、右辺は辺の番号を全部走って数えた
   破れボンド数から作っており、作り方が独立である。
5. 定理そのもの。$Z_L=\operatorname{Tr}(T^L)$ を確かめる。左辺は配位を全列挙して
   $x^{b(\sigma)}$ を足して作り（`partition_polynomial`、これは本文の定義そのままの実装である）、
   右辺は転送行列の積を $L-1$ 回繰り返してから対角成分を足して作る
   （`row_matrix_pow` と `row_matrix_trace`）。両者の作り方は独立である。

$L=1,2,3$（行配位は $2,4,8$ 個、配位は $2,16,512$ 個）で総当たりする。

### 計算の厳密性

すべて `ZZ` と `ZZ[x]` の厳密計算で行う。**浮動小数点は使わない。**
本文がこの章で $\mathbb{R}$ へ脱出していないので、検証側にも脱出を持ち込まない。

## 実行

```sh
sage sagemath/check/transfer-matrix-trace/check.sage
```

## 実行ステータスと結果

| 項目 | 状態 |
| --- | --- |
| 実行 | 2026-08-08 実行（SageMath, `/usr/local/bin/sage`） |
| 結果 | 全アサーション成立（$L=1,2,3$） |

出力:

```text
L = 1: Theta の全単射性・閉じた道の類別・族から作った道の重み・Z_L = Tr(T^L) を確認（Z_1 = 2）
L = 2: Theta の全単射性・閉じた道の類別・族から作った道の重み・Z_L = Tr(T^L) を確認（Z_2 = 2*x^8 + 12*x^4 + 2）
L = 3: Theta の全単射性・閉じた道の類別・族から作った道の重み・Z_L = Tr(T^L) を確認（Z_3 = 102*x^12 + 144*x^10 + 198*x^8 + 48*x^6 + 18*x^4 + 2）
すべてのアサーションが成立した（L = 1, 2, 3。厳密計算のみ）
```

### 表現についての注意

本文は $R_L$ の元そのものを行列の添字に使い、道を写像 $p:\{0,1,\dots,L\}\to R_L$、
族を写像 $c:\mathbb{Z}/L\mathbb{Z}\to R_L$ として書くが、検証側では行配位を
「列番号の順に値を並べたタプル」で表し（`row_config_key`）、道をその表現を並べた長さ $L+1$ の
タプル、族を長さ $L$ のタプルで表している。本文の射影 $\pi:\mathbb{Z}\to\mathbb{Z}/L\mathbb{Z}$ は
Python の `a % L`、代表を取る写像 $s:\mathbb{Z}/L\mathbb{Z}\to\mathbb{Z}$ は
（剰余類を $0,\dots,L-1$ で表しているので）恒等写像にあたる。
いずれも主張の内容には影響しない。

冪の添字は本文と同じ 1 始まりである（`row_matrix_pow(L, A, 1) == A`）。Lean 側だけは再帰が
`0` から始まるため引数を 1 つずらしてあり、本文の $T^L$ は Lean では
`rowMatrixPow L T (L - 1)` である。
