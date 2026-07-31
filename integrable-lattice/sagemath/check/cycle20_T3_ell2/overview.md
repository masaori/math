# cycle 20 / T3 Pure: $\ell=2$ の決着（ell_equals_2）— 対象ラベル

対応する証明本体: [`outputs/reports/cycle20_T3_ell_equals_2.md`](../../../outputs/reports/cycle20_T3_ell_equals_2.md)

## 対象ラベル（論文本文のブロック）

| ラベル | 本検証が支える内容 |
|---|---|
| `paper_prop_G` | $d=2$ 塔の低位項・退化点・消滅深度による記述。本検証は $\ell=2$ の場合（族 $p(1,0)+q(0,1)$ の全レベル・全点の付値と、そこから出る 4 通りの閉形式）を支える |
| `paper_prop_W` | $\mathrm{ord}_\ell(\kappa_n)$ の閉形式。本検証の定理 Y′ は $\ell=2$ での閉形式を与え、cycle 19 step 2 定理 X′（$\ell$ 奇）が $\ell=2$ で成り立つ範囲（系 Y″）を確定させる |

> 本 step では `structured-latex/content/` を編集していない（理由は report §12）。
> 上の 2 ラベルは反映先の候補として宣言してあるもので、反映は cycle 20 の総括で行う。

## 検証する命題（証明本体との対応）

| 証明本体の番号 | 内容 | Step |
|---|---|---|
| 命題 P1 | $\ell=2$ では族 $p(1,0)+q(0,1)$ は例外なく型 III（非退化も型 II も無い） | C1 |
| 補題 P2 | $p',q'$ 奇なら $\min(v_2(p'+q'),v_2(p'-q'))=1$ で両者は相異なる | （C2・C3 の場合分けが依存） |
| 補題 Y0 | レベルへの還元（スケール不変性の具体形） | A |
| 補題 Y3 | $\ell=2$ では $v_2(a'-b')$ と $v_2(a'+b')$ の $\min$ がちょうど 1 | D1, D2 |
| 命題 Y-A | case A の点ごとの付値（例外直線上／飽和／一般） | A |
| 補題 Y1 | 打ち消し（$U_e=U_o$）が起きるのは $\lambda_1=1$ かつ $(v_2(a_e),v_2(a_o))=(n-2,n-1)$ のときだけ | D3 |
| 補題 Y2 | 打ち消しでの真の値は $2+w$（$w=v_2(c_e/2+c_o)$）で、素朴な $\min$ より狭義に深い | D3, D3b |
| 定理 Y | $\ell=2$・族の点ごとの付値（全レベル・全点） | A |
| 補題 Y4 | レベルごとの両方奇の小計（cycle 16 補題 5.5 の一般化） | E |
| 定理 Y′ | $\ell=2$・族の閉形式（4 つの場合、全ての $n\ge1$） | B1, B2, B3 |
| 系 Y″ | 定理 X′（$\ell$ 奇）が $\ell=2$ で正しいのは case B かつ $\lambda_1\ge2$ のときちょうど | C3 |
| §3.1（命題 8 の $\ell=2$ 版） | 例外直線の方向と $\lambda$ が $\ell=2$ でも命題 8 のとおり | C2 |
| §6.1 | cycle 16 補題 5.5 = 定理 J7 の相殺 ＋ 飽和層 1 本 | E |
| §6.3 | 定理 J7 の (B\*) は破れるが $b=\sum j^*=2$ は当たる | F |
| §7 観察 G | **数値支持どまり**: 族の外の一般 $\ell=2$ 塔でも $b=\sum_{P\in S_\infty}j^*(P)$ | G |
| §11 | 敵対的レビュー | H |

## 実行

```bash
cd integrable-lattice/sagemath/check/cycle20_T3_ell2
sage ell2.sage > ell2.out 2>&1
```

詳細（手順・限界・結果）は [README.md](README.md) と [RESULTS.md](RESULTS.md)。
