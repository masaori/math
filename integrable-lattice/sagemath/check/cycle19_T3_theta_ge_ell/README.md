# cycle 19 / T3 Pure: 消滅深度 $\theta\ge\ell+1$ の領域の数値検証

対応する証明本体: [`outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md`](../../../outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md)

前提となる証明本体:
[`cycle18_T3_general_degenerate_tower.md`](../../../outputs/reports/cycle18_T3_general_degenerate_tower.md)（§6.1 が本サイクルの出発点。補題 A1–A5、定理 B・C、命題 F・G）、
[`cycle16_T3_lower_order_and_degeneracy.md`](../../../outputs/reports/cycle16_T3_lower_order_and_degeneracy.md)（定理 D1・D2、補題 5.5、§7 の型分類）、
[`cycle14_T3_two_variable_criterion.md`](../../../outputs/reports/cycle14_T3_two_variable_criterion.md)（式 $(1.1)$、補題 5.2）。

## 対象

cycle 18 は消滅深度

$$\theta(a,b)=\min\{m:\ell\nmid A_m(a,b)\},\qquad
A_m(a,b)=\sum_{(p,q)}c_{pq}\binom{pa+qb}{m}\in\mathbb{Z}$$

が **$\theta\le\ell$ の範囲でだけ**方向の不変量になることを示し、$\theta\ge\ell+1$ を未解決として残した
（同 §6.1: 「$\theta_M(a,b)$ を $\ell$ 進展開の桁ごとに記述する式が要る。これは予想ではなく、
次に試すべき具体的な手順である」）。本サイクルはその計算を実行する。

**視点の変更**: $\theta$ を $\mathbb{P}^1(\mathbb{F}_\ell)$（$\ell+1$ 点）上の関数にしようとするのをやめ、
最初から **$\mathbb{P}^1(\mathbb{Z}_\ell)$ 上の関数**として扱う。すると $M$ 依存は病理ではなくなり、
閉形式が出る条件は「$\theta$ が有限レベルで止まるか」になる。

## 検証する対象ラベル（証明本体の命題）

| ラベル | 内容 | 検証する Step |
|---|---|---|
| 補題 J0 | $\bar A_m$ は $(a,b)$ に $\ell$ 進連続。$\theta$ は $\mathbb{P}^1(\mathbb{Z}_\ell)$ 上の関数 | A |
| 定理 J2 | $0\le m\le\ell^L$ なら $\bar A_m$ は $(a,b)\bmod\ell^L$ だけの関数（桁定理） | A |
| 命題 J2′ | $m=\ell^L+1$ での破れは $\bar A_2$ の極形式。$\ell$ 奇なら「破れる $\iff k=2$」 | A |
| 定理 B′ | $\hat\theta_M=\min_m(\varphi(\ell^M)v_\ell(A_m)+m)$（最小点が一意なとき） | B |
| 定理 J4 | $\theta\ge\Lambda(r)=\min_j(e_j+j\ell^r)$、argmin 一意なら等号（ファイバー Newton 公式） | C |
| 系 J5 | $e_j+j\ell>e_0$（$\forall j\ge1$）なら $\theta$ はファイバー上定数 | C, E, G2 |
| 補題 J1 + 定理 K | $\mathrm{ord}_\ell(\kappa_n)$ が $D$ の係数だけからの有限計算で決まる | D |
| 定理 J6 / 系 J6b | $\theta$ 有限 ⇒ 型 II。$\ell=3$, $(1,0),(0,1),(1,1)$ で $5(3^n-1)-2n$ | E |
| 定理 J7 / 定理 J8 | $\theta=\infty$ ⇒ 型 III、$b=\sum j^*$。奇 $\ell$ の族で $2n\ell^n+2\ell^n-2$ | F, H3 |
| （$\ell=2$ の扱い） | $\ell=2$ トーラスでは $b$ は当たるが定理 J7 の仮定 (N)・(B\*) が破れており、証明が覆っていない | F |
| 補題 J9 / 系 J10 | $S_\infty$ は有限で、点はすべて有理点。候補は $\mathrm{supp}(\bar{\tilde E})$ の差ベクトルで尽きる | H1, H2 |
| §5.6（step 2 との突き合わせ） | 定理 J8 は step 2 定理 X′ の特別な場合。$b=\sum j^*$ と X′ の $b=2$ が整合する | H3, H4 |

> **注**: 以前この表にあった「命題 J7′（$j^*\le\ell-2$ が要る。$\ell=2$ トーラスが定理 J7 の反例）」は
> **撤回した**。$S_\infty$ を $\mathbb{P}^1(\mathbb{F}_\ell)$ の方向の集合だと取り違えたことによる誤りである
> （report §11.2）。$\ell=2$ トーラスでも $b=\sum j^*=2$ は当たり、破れているのは仮定 (N)・(B\*) である。

## 手順

```bash
cd integrable-lattice/sagemath/check/cycle19_T3_theta_ge_ell
sage theta_padic.sage > theta_padic.out 2>&1
sage j7_outside_family.sage > j7_outside_family.out 2>&1
```

**実行済み**: どちらも完走し、FAIL 0 件（`theta_padic` は 1327.2 秒、打ち切り 1 件）。
Step ごとの実数値は [RESULTS.md](RESULTS.md)。

`j7_outside_family.sage` は、**cycle 19 step 2（`cycle19_T3_theta_infinity.md`）§9.1 が
定理 X′ の反例として挙げた塔**で、本 step の定理 J7 の $n\ell^n$ 係数 $b=\sum_{P\in S_\infty}j^*(P)$ が
当たるかを確かめる（report §5.6 (d)）。塔の値は使わず、$\Theta_{M'}$ をレベルごとに厳密計算して
主要項を読む形なので、**当てはめに使っていないレベルで当たったことだけを証拠にしている。**

`_defs19.sage` は cycle 18 の `_defs18.sage`（さらにその先で cycle 16 の `_defs.sage`）を
`load` したうえで、$\Phi_{(a,b)}\in\mathbb{Z}[x]$、$\theta$、$\hat\theta$ の予言、
Hasse 微分 $\psi_j$ と $e_j$、$\Lambda(r)$、$\Theta_{M'}$ を追加する。
**塔の値 $\kappa_n$ は cycle 16 の Matrix-Tree 実装で計算しており、本サイクルの理論と独立である。**

## 限界（正直に記す）

- **塔の照合段数には上限がある。** $\ell^{2n}$ 頂点の被覆グラフのラプラシアン小行列式なので、
  $\ell=2$ で $n\le4$、$\ell=3$ で $n\le3$、$\ell=5$ で $n\le2$、$\ell=7$ で $n\le2$ に留めた。
- **Step A の全列挙は $\ell\le5$、$L\le2$。** $\ell=5$, $L=2$ と $\ell=3$, $L=3$ は
  間引き（step=4、$(a,b)$ 245 組）で例数を絞っている。間引き幅を $\ell$ の倍数に取ると
  破れを検出できなくなる（report §11.3）ため、$\ell$ と互いに素な幅にしてある。
- **母集団（Step D・G2）は bouquet 2–3 ループと 2 頂点 3 重辺（voltage 9 種）に限られる。**
  件数はこの母集団についてのものであって「全ての塔」についてではない。
  検出力（標本サイズから何 % の破れ率まで除外できるか）は report §9 に明記した。
- **$\ell=2$ で Step A の破れが 0 件なのは、検証不足ではなく命題 J2′ の帰結**
  （$\bar A_2$ が $\mathbb{F}_2$ 上の平方なら極形式は消える）。ログはこの判定も出す。
- **Step B で定理 B′ の最小点が一意でない点は、予言を「下界」としてしか照合していない。**
  そこは証明が何も言っていない場所である（report §7.1）。
- **Step D は $\ell$ ごとに壁時計 900 秒の上限を置いている。** 上限で打ち切った塔の件数は
  ログの「時間切れで未実施」欄と末尾の打ち切り一覧に全件出す（黙って打ち切らない）。
  **実際に $\ell=5$ で上限に達し、母集団 430 個のうち 176 個（すべて 2 頂点 3 重辺の族）が
  未実施のまま残った。** $\ell=2,3,7$ は全走査。詳細と、それによって狭まる照合範囲は
  [RESULTS.md](RESULTS.md) と report §9.1 に書いた。
- **Step H1・H2 の走査範囲は原始整数ベクトル $|a|,|b|\le5$ に絞っている。**
  系 J10 が言うのは $\mathbb{P}^1(\mathbb{Z}_\ell)$ 全体についてであり、この走査はその**部分集合**での照合である。
  系 J10 自体の証明は report §5.5 にあり、走査に依存していない。
- **`j7_outside_family.sage` の $\ell=5$ の例はレベル 5 の $\Theta$ に約 100 秒かかる。**
  レベル 6 以上は実施していない。
- Step A–H はいずれも証明済み命題の照合であり、証明の代用ではない。証明は report 本体にある。
