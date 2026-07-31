# cycle 19 / T3 Pure: 消滅深度が無限大の場合（$\theta=\infty$）の数値検証 — 対象ラベル

対応する証明本体: [`outputs/reports/cycle19_T3_theta_infinity.md`](../../../outputs/reports/cycle19_T3_theta_infinity.md)

## 対象ラベル（論文本文のブロック）

| ラベル | 本検証が支える内容 |
|---|---|
| `paper_prop_G` | $d=2$ 塔の低位項・退化点・消滅深度による記述。本検証は (G7)（$\theta=\infty$ の軌跡と、それを持つ族の閉形式）を支える |
| `paper_prop_W` | $\mathrm{ord}_\ell(\kappa_n)$ の閉形式（本検証の定理 X′ はその $n\ell^n$ 項が odd $\ell$ で現れる具体族） |

## 検証する命題（証明本体との対応）

| 証明本体の番号 | 内容 | Step |
|---|---|---|
| 定理 S | 段階的処理: $v_\ell(E)=\lambda+\theta^*/\varphi(\ell^M)$（$\theta^*-m_1<\varphi(\ell^M)$） | A |
| 命題 2 | $\lambda(u)\ge1\iff(\chi^{u^\perp}-1)\mid\bar{\tilde E}$ | B1 |
| 命題 3 | 例外直線は $\mathrm{Newt}$ の Minkowski 因子。有限・計算可能 | B2, H5 |
| 補題 4 | スケール不変性 $\lambda(cu)=\lambda(u)$, $\theta^*(cu)=\theta^*(u)$ | C |
| 系 5 | 同居構造の計数（直線ごとに $\varphi(\ell^M)$ 個、割合 $\ell^{1-M}$） | D |
| 系 6 | 例外方向では一般点も $\theta\ge\ell+1$（cycle 18 定理 C の射程外） | E |
| 命題 7 | 例外直線の $\Sigma_n$ への寄与 $\lambda(\ell^n-1)+n\theta^*$（$n\ell^n$ を作らない） | F4, H4 |
| 命題 8 | 族 $p(1,0)+q(0,1)$ の例外直線の完全決定（$\theta=\infty\iff\ell\mid p'q'(p'+q')$） | G2 |
| 定理 X | 同族の点ごとの付値の閉形式（$\ell$ 奇） | F1 |
| 定理 X′ | $\mathrm{ord}_\ell(\kappa_n)=\mu(\ell^{2n}-1)+2n\ell^n+\Lambda(\ell^n-1)$ | F2, F3 |
| 系 X″ | 任意の奇素数で型 III | F3, H3 |
| 命題 9 | $\ell$ 奇ならこの族は全塔が覆われる | F5 |
| §9.1 | 定理 X′ の素朴な一般化は**偽**（反例） | H6 |
| §9.3 | $\ell=2$ では定理 X′ は成り立たない（既知の cycle 16 定理 D2 が正しい） | H2 |
| §6.2 | 母集団 566 塔の全走査による分類 | G |

## 実行

```bash
cd integrable-lattice/sagemath/check/cycle19_T3_theta_infinity
sage theta_infinity.sage > theta_infinity.out 2>&1
```

詳細（手順・限界・結果）は [README.md](README.md) と [RESULTS.md](RESULTS.md)。
