# cycle 19 / T3 Pure: 消滅深度 $\theta\ge\ell+1$ の領域の数値検証 — 対象ラベル

対応する証明本体: [`outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md`](../../../outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md)

## 対象ラベル（論文本文のブロック）

| ラベル | 本検証が支える内容 |
|---|---|
| `paper_prop_J` | 桁定理、ファイバー Newton 公式、型 II / 型 III の判別（本検証の Step A–H が全項目に対応する） |
| `paper_prop_G` | $d=2$ 塔の低位項・退化点・消滅深度。本検証は (G1″)（$\theta\le\ell$ でだけ方向の不変量）を $\mathbb{P}^1(\mathbb{Z}_\ell)$ 上へ拡張する部分を支える |

## 検証する命題（証明本体との対応）

| 証明本体の番号 | 内容 | Step |
|---|---|---|
| 補題 J0 | $\bar A_m$ は $(a,b)$ に $\ell$ 進連続。$\theta$ は $\mathbb{P}^1(\mathbb{Z}_\ell)$ 上の関数 | A |
| 定理 J2 | $0\le m\le\ell^L$ なら $\bar A_m$ は $(a,b)\bmod\ell^L$ だけの関数（桁定理） | A |
| 命題 J2′ | $m=\ell^L+1$ での破れは $\bar A_2$ の極形式。$\ell$ 奇なら「破れる $\iff k=2$」 | A |
| 定理 B′ | $\hat\theta_M=\min_m(\varphi(\ell^M)v_\ell(A_m)+m)$（最小点が一意なとき） | B |
| 定理 J4 | $\theta\ge\Lambda(r)=\min_j(e_j+j\ell^r)$、$\mathrm{argmin}$ 一意なら等号 | C |
| 系 J5 | $e_j+j\ell>e_0\ (\forall j\ge1)$ なら $\theta$ はファイバー上定数 | C, E, G2 |
| 補題 J1 + 定理 K | $\mathrm{ord}_\ell(\kappa_n)$ が $D$ の係数だけからの有限計算で決まる | D |
| 定理 J6 / 系 J6b | $\theta$ 有限 ⇒ 型 II。$\ell=3$, $(1,0),(0,1),(1,1)$ で $5(3^n-1)-2n$ | E |
| 定理 J7 | $n\ell^n$ の係数 $b=\sum_{P\in S_\infty}j^*(P)$ | F, H3, `j7_outside_family` |
| 定理 J8 | 奇 $\ell$ の族で $\mathrm{ord}_\ell(\kappa_n)=2n\ell^n+2\ell^n-2$ | F, H3 |
| 補題 J9 / 系 J10 | $S_\infty$ は有限で、点はすべて有理点。候補は $\mathrm{supp}(\bar{\tilde E})$ の差ベクトルで尽きる | H1, H2 |
| §5.4 | $\ell=2$ トーラスでは $b$ は当たるが仮定 (N)・(B\*) が破れ、証明が覆っていない | F |
| §5.6 | cycle 19 step 2（定理 X′）との突き合わせ。重複と食い違いの処理 | H3, H4, `j7_outside_family` |

## 並行 step との関係

同じ cycle の step 2（[`cycle19_T3_theta_infinity.md`](../../../outputs/reports/cycle19_T3_theta_infinity.md)、
検証は [`../cycle19_T3_theta_infinity/`](../cycle19_T3_theta_infinity/)）と主張が重なる部分がある。

- **定理 J8 は step 2 定理 X′ の $(p,q)=(\ell-1,1)$ の場合**であり、族としての正本は step 2 側である。
  本検証 Step H3 は 146 組でこの整合を確かめている。
- **$S_\infty$ の有限性**は、step 2 命題 3（$\mathbb{Z}^2$ の直線として有限）と
  本 step 系 J10（$\mathbb{P}^1(\mathbb{Z}_\ell)$ の点として有限）を**合わせて**完全になる。
- **$n\ell^n$ の出所**について両者は同じことを言っている（$S_\infty$ の点そのものではなく、その近傍）。
  食い違いは無い（report §5.6 (b)）。

## 実行

```bash
cd integrable-lattice/sagemath/check/cycle19_T3_theta_ge_ell
sage theta_padic.sage > theta_padic.out 2>&1
sage j7_outside_family.sage > j7_outside_family.out 2>&1
```

詳細（手順・限界）は [README.md](README.md)、Step ごとの実数値は [RESULTS.md](RESULTS.md)。

## 実行ステータスと結果

| スクリプト | 状態 | FAIL 件数 | 打ち切り | 所要 |
|---|---|---|---|---|
| `theta_padic.sage` | **完走** | **0** | **1 件**（下記） | 1327.2s |
| `j7_outside_family.sage` | **完走** | **0** | 0 件 | 約 102s |

主要な数値: Step D の照合 **2128 段すべて一致**（$\ell=2$: 374 / $\ell=3$: 537 / $\ell=5$: 627 / $\ell=7$: 590）、
Step G2 で系 J5 が新たに扱える塔 **117 個**、Step H1/H2 の走査 **68880 組**で系 J10 の候補集合の外 **0 件**、
Step H3 の **146 組・例外直線 196 本**すべてで $b=2$。

### 打ち切った計算（1 件・黙って落とさない）

**Step D の $\ell=5$**: $\ell$ ごとの壁時計上限 900 秒に達し、母集団 430 個のうち
**先頭 254 個までしか処理していない（残り 176 個が未実施）**。

- 落ちた 176 個は**すべて 2 頂点 3 重辺の族**である（bouquet 210 個は全て処理済み）。
  内訳は「第 1 辺の voltage が $(1,0)$ で列挙の後半に来るもの 11 個」＋
  「第 1 辺の voltage が $(1,0)$ 以外のもの 165 個」。
- **狭まる照合範囲**: $\ell=5$ における「定理 K の予言が塔の値と一致する」ことと
  「最小点の一意性が破れた塔が 0 個」という観察は、**母集団の 59%（254/430）についての話**になる。
  未実施の 176 個については当たるとも外れとも主張していない。
- 影響するのは数値支持どまりの部分（report §9.1）だけで、**定理・命題の証明には影響しない**
  （証明は有限個の例に依らない）。
