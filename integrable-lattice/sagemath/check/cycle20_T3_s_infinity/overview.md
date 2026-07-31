# cycle 20 / T3 Pure: $S_\infty$ の判定手続き（一般の塔）の数値検証 — 対象ラベル

対応する証明本体: [`outputs/reports/cycle20_T3_s_infinity_decision.md`](../../../outputs/reports/cycle20_T3_s_infinity_decision.md)

## 対象ラベル（論文本文のブロック）

| ラベル | 本検証が支える内容 |
|---|---|
| `paper_prop_K` | 本検証の主対象。$S_\infty$ の判定手続き (K3)、$j^*=$ 重複度 (K4)、仮定 (N) の解消 (K5)、$n\ell^n$ の係数 $b=\sum m_i$ (K6)、a priori 上界 (K7) |
| `paper_prop_J` | (J4) が置いていた仮定のうち (N) が不要になること、(J6) の「候補集合の各点での判定は未実装」という限界が解消されたこと |
| `paper_prop_G_infty` | 例外直線（$\mathbb{Z}^2$ の直線）と $S_\infty$（$\mathbb{P}^1(\mathbb{Z}_\ell)$ の点）が同一の有限集合であること (K1)、判定条件が同じものであること (K2) |

## 検証する命題（証明本体との対応）

| 証明本体の番号 | 内容 | Step |
|---|---|---|
| 補題 W2 | 判定条件 4 つ（$\theta=\infty$ / $\lambda\ge1$ / $(\chi^{u^\perp}-1)\mid\bar{\tilde E}$ / 各 $\gamma$ 類の係数和）の同値 | A |
| 定理 W1 | $S_\infty$（step 1 の見方）と例外直線（step 2 の見方）が同一の集合 | B |
| 定理 W4 | $j^*(P)=m_P$（二項式因子の重複度）、および $e_j=\infty\,(j<m)$, $e_m<\infty$ | C |
| 系 W5 | 明示式 $(5.1)$ の $r_0$ 以降で $\Lambda(r)$ の $\mathrm{argmin}$ が一意（仮定 (N) の解消） | D |
| 定理 J4 / 定理 S | 層ごとの内訳（各 $P$・各層 $r$ での $\hat\theta_M$ と $\Lambda(r)$、最内点での定理 S） | E′ |
| 系 W6 | $b=\sum_P m_P$ を $\Theta_M$ からの独立抽出と照合 | E |
| （実装の健全性） | $\sum_M\Theta_M$ から作った $\mathrm{ord}_\ell(\kappa_n)$ と Matrix–Tree の照合 | F |
| 系 W7 | $b\le\frac12\,\mathrm{per}(\mathrm{Newt}(\bar{\tilde E}))$ | G |
| §8 | 敵対的レビュー（(B\*) が破れる塔 / $b\ge3$ / 重複度 $\ge2$ / 候補集合の外） | H |
| §7.2 | 母集団の分類（$b$ の分布） | I |

## 実行

```bash
cd integrable-lattice/sagemath/check/cycle20_T3_s_infinity
sage s_infinity.sage > s_infinity.out 2>&1
```

詳細（手順・限界・結果）は [README.md](README.md) と [RESULTS.md](RESULTS.md)。
