# SageMath Check: 行配位の巡回シフト

## 対象

**対象ラベル**: `def_column_translation` / `claim_column_translation_bijective` /
`def_row_config_shift` / `claim_row_config_shift_bijective` /
`claim_intra_row_shift_invariant` / `claim_inter_row_shift_invariant` /
`claim_transfer_matrix_shift_invariant`
（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の定義 2 件
  （「列番号の平行移動」「行配位の巡回シフト」）と主張 5 件
- 併せて使う定義: `def_lattice` / `def_row_configuration` /
  `def_intra_row_broken_count` / `def_inter_row_broken_count` / `def_transfer_matrix`

### 何を確定させるための検証か

本文は、列番号を 1 つ進める平行移動 $\gamma(y)=y+_{\mathbb{Z}/L\mathbb{Z}}\bar1$ と、それで
行配位を引き戻す巡回シフト $\bigl(S(\tau)\bigr)(y)=\tau(\gamma(y))$ を定め、転送行列の成分が
行と列を同時にシフトしても変わらないこと $T_{S(\tau),S(\tau')}=T_{\tau,\tau'}$ を示している。
これは次のセクションで転送行列を巡回シフトで分けるための足場である。
この検証は、定義と 5 つの主張を小さい $L$ で総当たりに固定する。

1. `def_column_translation`。$\gamma$ が $\mathbb{Z}/L\mathbb{Z}$ の写像として定まること。
2. `claim_column_translation_bijective`。人手証明の作り方そのもの（逆向きの平行移動 $\gamma'$ を
   置き、$\gamma'\circ\gamma$ と $\gamma\circ\gamma'$ が恒等写像であること）を全ての $y$ について。
   あわせて像が $\mathbb{Z}/L\mathbb{Z}$ 全体であることも見る（全射性を別の作り方で確かめるため）。
3. `def_row_config_shift`。$S(\tau)$ が行配位であること（定義域が $\mathbb{Z}/L\mathbb{Z}$、
   値が $\{+1,-1\}$）。
4. `claim_row_config_shift_bijective`。$S'\circ S$ と $S\circ S'$ が恒等写像であることを
   全ての行配位について。あわせて像が $R_L$ 全体であることも見る。
5. `claim_intra_row_shift_invariant`。$b_{\mathrm{h}}(S(\tau))=b_{\mathrm{h}}(\tau)$。
6. `claim_inter_row_shift_invariant`。$b_{\mathrm{v}}(S(\tau),S(\tau'))=b_{\mathrm{v}}(\tau,\tau')$。
7. `claim_transfer_matrix_shift_invariant`。$T_{S(\tau),S(\tau')}=T_{\tau,\tau'}$。

5 と 6 では、最終の等式（個数の一致）だけでなく、**人手証明の準備そのもの**——
$b_{\mathrm{h}}(S(\tau))$ を定める集合が $X$ の $\gamma$ による逆像であること、
$b_{\mathrm{v}}(S(\tau),S(\tau'))$ を定める集合が $Y$ の逆像であること——を集合の一致として
確かめている。個数だけを見ると、集合の取り違え（例えば $\gamma$ の向きの取り違え）が
個数の一致に隠れる場合を検出できないためである。

7 では左辺も右辺も同じ転送行列から添字を引いて比べており、行列は
`_shared/defs.sage` の `transfer_matrix(L)` が定義どおり（破れの本数を指数に置く形）に
組み上げたものである。

### 主張が空でないことの確認

不変性の主張は、量がそもそも定数なら自明に成り立つ。そこで L = 3 で次を確かめている。

- $b_{\mathrm{h}}$ は行配位によって実際に異なる値を取る（少なくとも 2 通り）。
- $b_{\mathrm{v}}(S(\tau),\tau')$ が $b_{\mathrm{v}}(\tau,\tau')$ と異なる対が存在する。
  すなわち**両方を同時にシフトすることが効いている**（片側だけでは不変にならない）。
- 転送行列の成分は行配位の対によって実際に異なる。

### 走らせた範囲（打ち切りを隠さない）

| $L$ | 行配位 $|R_L|$ | 1〜5 で見た行配位 | 6・7 で見た行配位の対 |
|---|---|---|---|
| 1 | 2 | 全 2 個 | 全 4 通り |
| 2 | 4 | 全 4 個 | 全 16 通り |
| 3 | 8 | 全 8 個 | 全 64 通り |
| 4 | 16 | 全 16 個 | 全 256 通り |

$L\le4$ については**総当たりであり標本ではない**。$L$ の全体は無限集合なので、
$L$ については 4 つの値に限っている。

### 計算の厳密性

すべて `ZZ` / `ZZ[x]` の厳密計算で行う。**浮動小数点は使わない。**
本文がこの範囲で $\mathbb{R}$ へ脱出していないので、検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-08 | すべて通過（$L=1,2,3,4$。上の 1〜7 と「主張が空でないことの確認」） |

```
sage sagemath/check/row-config-shift/check.sage
```
