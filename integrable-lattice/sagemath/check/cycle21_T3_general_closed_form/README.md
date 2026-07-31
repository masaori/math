# cycle 21 / T3 Pure: 一般の塔の閉形式（5 係数すべて）— 手順と限界

対応する証明本体: [`outputs/reports/cycle21_T3_general_closed_form.md`](../../../outputs/reports/cycle21_T3_general_closed_form.md)
対象ラベルの宣言: [overview.md](overview.md) / 実行結果: [RESULTS.md](RESULTS.md)

## ファイル

| ファイル | 役割 |
|---|---|
| `_defs21.sage` | 共有定義。`../cycle20_T3_s_infinity/_defs20.sage` を load する（さらにその土台は cycle 19 / 18 / 16） |
| `general_closed_form.sage` | Step A–F（既知形との突き合わせ・母集団走査・分布・naive 版の破れ・層ごと照合・$b=\sum j^*$） |
| `tower_values.sage` | Step G（Matrix–Tree 定理による塔の値との照合） |
| `*.out` | 生ログ |

## `_defs21.sage` が提供するもの

| 関数 | report の対応 | 内容 |
|---|---|---|
| `sinf_r0(S, ell)` | 系 W5 | $r_0=1+\max_{P\ne P'}v_\ell(\det(u,u'))$ |
| `Rprime(rec, ell, r0)` | §4 | $r\ge R'$ で $\Lambda(r)$ の argmin が $j^*$ だけになる最小の $R'$ |
| `sat_depth(rec, ell)` | 定理 G3 | 飽和深度 $K=\max\{k\ge0: j^*\ell\ge(\ell-1)\ell^k\}$（境界は $e_{j^*}$ と $m_1$ で判定） |
| `twisted_stage(Ev, ell, u, k)` | 定理 G2 | 捻り段データ $(\Lambda_k,\theta^\sharp_k,m^\sharp_k)$。$\mathbb{Z}[\zeta_{\ell^k}]$ 上の付値をノルムの $v_\ell$ で計算する |
| `gen_sum(Ev, ell, S, rsharp, L)` | $(5.1)$ | $U$ 上の $\theta$ の和（$A_{\mathrm{gen}}\ell^L$） |
| `closed_form(m, edges, ell)` | 定理 G4 | $(\alpha,\beta,\gamma)$ と $(a,b,c,d)$。**塔の値も $\Theta_M$ の実測も使わない** |
| `Mstar(P, ell)` | §5.3 | $(2.1)$ が成り立つ十分条件としての $M^*$ |
| `theta_pred(P, ell, M)` | $(2.1)$ | $\alpha M\ell^M+\beta\ell^M+\gamma$ |

実測側は `../cycle20_T3_s_infinity/_defs20.sage` の `hat_theta_exact` / `Theta_level`
（cycle 20 定理 L4 の整数終結式）をそのまま使う。

## 検証の設計上の約束

1. **予言側は当てはめを一切しない。** $(\alpha,\beta,\gamma)$ は $D$ の係数からの計算だけで決まる。
   したがって照合は自由度 0 であり、$M$（あるいは $n$）を 1 つ増やすたびに新しい out-of-sample 点が増える。
2. **実測側は本サイクルの理論から独立。** $\hat\theta_M$ は整数終結式（定理 L4、仮定なし）で、
   Step G はさらに Matrix–Tree 定理で塔の値そのものを計算する。
3. **$M<M^*$ は照合しない。** 定理 G4 は $M\ge M^*$ でしか主張しないので、それより小さい $M$ は
   「外れても反例ではない」。Step G は $n<n_0$ のずれを別カウントで出す（隠さないため）。
4. **打ち切りは件数と中身を必ず出力する。** 各スクリプトに壁時計上限を置き、
   超えたら未実施の範囲をログ末尾と RESULTS.md に全件書く。

## 母集団

cycle 20 step 2 の検証（`../cycle20_T3_s_infinity/s_infinity.sage`）と**同一の構成**を使う（比較可能性のため）。

- 1 頂点 bouquet、ループ 2 本・3 本、voltage は $(1,0),(0,1),(1,1),(1,-1),(2,1),(1,2)$ から重複ありで選ぶ（21 + 56 塔）。
- 2 頂点平行 3 重辺、voltage は $(0,0),(1,0),(0,1),(1,1)$ から重複ありで選ぶ（20 塔）。
- 族 $p(1,0)+q(0,1)$（$1\le p\le q\le6$、21 塔）。
- 敵対的に選んだ名前つきの塔 6 個（$\ell=2$ トーラス、$j^*=\ell-1$ になる塔など）。
- **合計 124 塔。**

> cycle 20 step 1 の report が「母集団 430 個」と書いているのは別の構成（bouquet 210 ＋ 2 頂点 3 重辺 220）で、
> 本検証の 124 塔とは直接比較できない。本検証が同一にしているのは cycle 20 step 2 の構成である。

素数は $\ell\in\{2,3,5,7\}$。母集団走査のレベルは `MMAX = {2:7, 3:5, 5:3, 7:3}`、
名前つきの塔だけの深い掃引は `MMAX_DEEP = {2:9, 3:6, 5:4}` まで。

## 限界（結論の射程）

- **$d=2$ のみ。** cycle 14 $(6.1)$ が $d=2$ の式なので、$d\ge3$ は対象外。
- **母集団の外については何も主張しない。** 定理 G1–G4 の証明は母集団に依存しないが、
  照合はこの範囲でしか行っていない。
- **段数の壁。** Step G の Matrix–Tree は $\ell^{2n}|V|$ 次の行列式なので $\ell=2$ で $n\le4$、
  $\ell=3$ で $n\le3$、$\ell=5$ で $n\le2$ に留める。
- **(H) を満たさない塔は除外する**（全段連結でないと $(6.1)$ が使えない）。除外件数はログに出す。
