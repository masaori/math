# cycle 20 / 運用: cycle 19 の新定理群を Lean で検算する（定理 J2・定理 X′・定理 J6・定理 J7）

対象: cycle 19 で得た新定理群（`auto-loop-state.md` の cycle 20 step 4）。
**目的は証明の正しさではなく、主張が一意に読めるか・仮定が過不足ないかの検査**である
（cycle 17 は命題 B の誤り、cycle 18 は命題 N・W の誤り、cycle 19 は過剰仮定 2 件を検出しており、
本サイクルで 4 サイクル連続になる）。

前提として読んだ一次情報:
`outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md`（定理 J2・命題 J2′・定理 J6・定理 J7・定理 J8）、
`outputs/reports/cycle19_T3_theta_infinity.md`（命題 8・定理 X・定理 X′・系 X″）、
`outputs/reports/cycle19_T3_trace_period_closed_form_and_lean.md` §1、
`outputs/reports/cycle18_ops_lean_props_NTW.md`、`lean/README.md`、
本文 `structured-latex/content/008_theta_padic.ts`（命題 J）・`005b_theta_infinity.ts`（命題 G′）。

---

## 0. 結論（先に置く）

| 検出 | 内容 | 状態 |
|---|---|---|
| **誤り 1 件** | cycle 19 step 2 report §5.4 の例示 2 つ（$\ell=7$ の $(3,4)$、$\ell=11$ の $(5,6)$）が、$\Lambda$ を **2 分の 1 に取り違えている**。真値は $2n\ell^n+2(\ell^n-1)$ | §1。**論文本文は無傷**（誤りは report の例示だけ） |
| **暗黙の仮定 1 件** | 本文 命題 J の (J1)（桁定理）が $A_1\equiv0$ を仮定として書いていない。$m=\ell^L$ ちょうどの段はこれなしでは**偽** | §2。**本文を訂正した**（反例つき） |
| **過剰仮定 2 件** | 定理 J6 の仮定 (ii)（$\theta^{\max}-2<\varphi(\ell^{n_1})$）は閉形式を出す総和の段には効かない。「係数が $L$ に依らない」は 2 つの比例関係だけから出る | §3 |
| **食い違い無し** | 桁定理・命題 J2′ の等式・命題 8 の排反性・定理 X′ の数え上げと総和・定理 J8 の閉形式は、いずれも人手証明の通りに Lean で通った | §4 |
| **相互検証の再現** | 定理 J8（step 1 の道具）と定理 X′ の $\Lambda=2$（step 2 の道具）が Lean 上でも一致する | §4.3 |
| 検証 | `lake build` **8671 jobs** / `BUILD_EXIT=0`、`check-no-sorry.sh` で列挙した **156 個**の定理がすべて `sorryAx` 非依存 / `CHECK_EXIT=0` | §6 |

---

## 1. 検出した誤り: cycle 19 step 2 report §5.4 の例が $\Lambda$ を取り違えている

### 1.1 何が書いてあるか

`cycle19_T3_theta_infinity.md` §5.4（系 X″ の解説）は次のように書いている。

> **すべての奇素数 $\ell$ で型 III が現れる**（例: $\ell=7$ の $(p,q)=(3,4)$ で
> $\mathrm{ord}_7(\kappa_n)=2n7^n+7^n-1$、$\ell=11$ の $(5,6)$ で $2n11^n+11^n-1$）。

### 1.2 なぜ誤りか

$(p,q)=(3,4)$、$\ell=7$ は $\mu=v_7(\gcd(3,4))=0$、$p'=3$、$q'=4$、$p'+q'=7$ なので
**命題 8 の場合 [A]（$\ell\mid p'+q'$）**である。同命題の表より例外直線は
$\mathbb{Z}(1,1)$ と $\mathbb{Z}(1,-1)$ の **2 本**で、各々 $\lambda=v_7(7)=1$、したがって

$$\Lambda=\sum_{\text{例外直線}}\lambda=2\cdot1=2 .$$

定理 X′ に入れると $\mathrm{ord}_7(\kappa_n)=2n\,7^n+2(7^n-1)$ であって、
§5.4 の $2n7^n+(7^n-1)$ ではない。$\ell=11$ の $(5,6)$（$p'+q'=11$）も同じで $\Lambda=2$ である。
**$\Lambda$ の定義（例外直線**すべて**についての和）を、1 本ぶんの $\lambda$ と取り違えている。**

### 1.3 独立に確かめた

定理 X′ の総和を使わず、**定理 X の点ごとの値を直接数えて** $\Sigma_1$ を出した
（$\ell=7$、$m=1$、$\varphi_1=6$、$\lambda_0=1$）。

| 点の種類 | 個数 | $\varphi_1 v_\ell(E)$ | 小計（$v$ の和） |
|---|---|---|---|
| 片方だけ単元 | $12$ | $2$ | $4$ |
| 両方単元、$a\equiv\pm b$ | $12$ | $\lambda_0\varphi_1+2=8$ | $16$ |
| 両方単元、$a\not\equiv\pm b$（$r=0$） | $24$ | $2$ | $8$ |
| 合計 | $48=7^2-1$ | | $\Sigma_1=28$ |

$(1.1)$ より $\mathrm{ord}_7(\kappa_1)=\Sigma_1-2=26$。
一方 $2n7^n+2(7^n-1)$ は $n=1$ で $14+12=26$ で**一致**し、
§5.4 の $2n7^n+(7^n-1)$ は $14+6=20$ で**一致しない**。
個数の内訳（$12/12/24$、合計 $48$）は Lean の `card_one_zero_seven` / `card_diag_seven` /
`card_generic_seven` で `decide` により確認した。数値の食い違いは
`cycle19_5_4_example_mismatch`（$26\neq20$）として Lean に残した。

### 1.4 波及範囲（限定的である）

- **論文本文 `paper_prop_G_infty`（`structured-latex/content/005b_theta_infinity.ts`）は無傷**である。
  本文は $\Lambda:=\sum_{\text{例外直線}}\lambda$ と定義したうえで閉形式を書いており、
  §5.4 の 2 つの例示は本文に載っていない。
- **定理 X′ 本体・命題 8 の表・§5.3 の証明・機械検証 Step F3（フィット 0 個で塔の値と照合）は
  いずれも正しい。** 同じ族の $(p,q)=(\ell-1,1)$ を扱う step 1 の定理 J8 も
  $2n\ell^n+2\ell^n-2$（＝$\Lambda=2$）と正しく書いている。
- したがって誤りは **§5.4 の例示 2 行だけ**である。
- **本 step の担当範囲は本文 `structured-latex/content/` と本 report なので、
  cycle 19 の report 側の文面はこの step では書き換えていない**（衝突回避の指示による）。
  訂正内容は上記の通りで、$7^n-1$ → $2(7^n-1)$、$11^n-1$ → $2(11^n-1)$ と直せばよい。

---

## 2. 検出した暗黙の仮定: 桁定理は $A_1\equiv0$ なしには偽

### 2.1 何が抜けていたか

本文 命題 J の (J1) は次のように述べていた（訂正前）。

> $L\ge1$ とすると、$0\le m\le\ell^L$ なる $m$ について $A_m(a,b)\bmod\ell$ は
> $(a,b)\bmod\ell^L$ だけの関数である。

Lean で形式化するとき、係数 $\bar c_{pq}$ と台 $S$ を任意に取れる形で
$\bar A_m(a,b)=\sum_{(p,q)\in S}\bar c_{pq}\binom{pa+qb}{m}$ を定義した（`Abar`）。
すると **$m<\ell^L$ の段は仮定なしで通る**（`Abar_shift_lt`。Lucas の定理だけ）が、
**$m=\ell^L$ ちょうどの段は通らない**。通すには

$$\bar A_1(u,v)=\sum_{(p,q)}\bar c_{pq}\,\overline{(pu+qv)}=0\qquad(\forall u,v)$$

が要る（`Abar_shift` の仮定 `hA1`）。実際、$\tilde E=z$（$S=\{(1,0)\}$、$c=1$）、$\ell=3$、$L=1$ とすると
$\bar A_3(3,0)=\binom33=1$、$\bar A_3(0,0)=\binom03=0$ で**破れる**
（`cexDigit_fails`。同じ例で $m=2<3$ では一致する: `cexDigit_lt_holds`）。

### 2.2 これは本文の穴であって、根拠 report の穴ではない

根拠 report `cycle19_T3_theta_ge_ell_plus_1.md` §2.2 の証明は、
$m=\ell^L$ の段で cycle 18 補題 A2 (1)（$A_1\equiv0$ は $D(z,w)=D(z^{-1},w^{-1})$ から従う
整数としての恒等式）を**明示的に引いている**。**report は正しく、本文 (J1) が
それを暗黙の前提として落としていた。**

### 2.3 本文を訂正した

`structured-latex/content/008_theta_padic.ts` の (J1) に、
$m=\ell^L$ の段で $A_1\equiv0$ を使うこと・その出所（`paper_prop_G` の (G6)）・
落とすと偽になる反例・$m<\ell^L$ の段は使わないことを追記した（最小限の追記のみ）。

### 2.4 ついでに分かったこと（命題 J2′ は $A_1\equiv0$ を使わない）

命題 J2′（閾値 $m=\ell^L+1$ での破れが双一次形式 $\bar B$ で与えられる）の等式本体は、
$A_1\equiv0$ を**使わずに**成り立つ（`Abar_shift_pow_succ`）。
人手証明も使っていないが、§2.3 の書き方からは読み取りにくい。
また、この定理の右辺 $\bar B$ に $L$ が現れないことが「$L$ に依らない」の内容であり、
Lean では型からそれが直接読める。

---

## 3. 検出した過剰仮定（定理 J6）

### 3.1 仮定 (ii) は総和の段には効かない

定理 J6 の仮定は

- (i) $\theta$ が $\mathbb{P}^1(\mathbb{Z}_\ell)$ 上で至る所有限（レベル $L$ を経由する）、
- (ii) $n_1\ge L$ を $\theta^{\max}-2<\varphi(\ell^{n_1})$ を満たすように取る

の 2 つである。しかし閉形式そのものを出す計算（`sum_level_stab`）が使うのは

$$1\le L\le n_1\quad\text{と}\quad \Theta_{M'}=\ell^{M'-L}\Theta_L\ (M'\ge n_1)$$

**だけ**である。$\theta^{\max}-2<\varphi(\ell^{n_1})$ は
$\hat\theta_{M'}=\theta$（測る量が $\theta$ に一致すること）を保証するための仮定であって、
そこから先の幾何級数の総和には一切効かない。**定理 J6 の主張は
「$n_1$ の存在条件」と「$n_1$ 以降の安定性」という異なる役割の仮定を混ぜて述べている。**
人手証明の議論の順序は正しいが、定理の形としては
「$\Theta$ がレベル $n_1$ 以降で $\ell$ 倍で安定するなら閉形式が出る」と分離できる。

### 3.2 「係数が $L$ に依らない」は比例関係 2 本だけから出る

定理 J6 は末尾で「係数 $\Theta_L/\varphi(\ell^L)$ は $L$ の取り方に依らない」と述べる。
これは `level_ratio_indep` の通り、$\Theta_{L'}=\ell^{L'-L}\Theta_L$ と
$\varphi(\ell^{L'})=\ell^{L'-L}\varphi(\ell^L)$ という **2 つの比例関係だけ**から出る
（$\theta$ の有限性も $\mathbb{P}^1$ のファイバーの一様性も、この段では使わない）。

### 3.3 過剰仮定は検出されなかった箇所

命題 8 の排反性（`bouquet_cases_exclusive`）は、$p',q'$ が同時に $\ell$ で割れないことだけから出て、
**$\ell$ の奇偶も素数性も使わない**。人手証明もそれを仮定していないので、ここは過不足がない。
$\ell$ が奇であることが効くのは定理 X の 3 箇所で、report の注 5.2 がその 3 箇所を正しく挙げている。
そのうち (ii)（$a'\equiv b'$ と $a'\equiv-b'$ の排反性）は
`card_diag_two`（$\ell=2$ では該当点が $2\varphi$ ではなく $\varphi$ 個）として Lean で確認した。

---

## 4. 形式化した内容

### 4.1 `IntegrableLattice/DigitTheorem.lean`（定理 J2・命題 J2′）

| 定理 | 内容 |
|---|---|
| `choose_cast_of_lt` | $m<\ell^L$ なら $\binom Nm\bmod\ell$ は $N\bmod\ell^L$ だけの関数（補題 J0） |
| `choose_cast_pow` | $\binom{N}{\ell^L}\equiv N/\ell^L$（第 $L$ 桁が裸で出る段） |
| `choose_cast_pow_succ` | $\binom{N}{\ell^L+1}\equiv(N/\ell^L)(N\bmod\ell)$ |
| `Abar_shift` | **定理 J2 本体**（仮定は $\bar A_1\equiv0$ だけ） |
| `Abar_mod` / `Abar_congr` | $\bar A_m$ が $(a,b)\bmod\ell^L$ だけの関数であること |
| `Abar_shift_pow_succ` | **命題 J2′ の等式本体**（右辺に $L$ が現れない） |
| `Bbar_diag` | $\bar B(x,x)=2\bar A_2(x)$（極形式であること） |
| `cexDigit_fails` / `cexDigit_lt_holds` | §2 の反例と対照 |

土台は mathlib の Lucas の定理
`Choose.choose_modEq_choose_mul_prod_range_choose`（`Mathlib/Data/Nat/Choose/Lucas.lean`）である。

### 4.2 `IntegrableLattice/BouquetClosedForm.lean`（命題 8・定理 X′）

- `bouquet_cases_exclusive` — 命題 8 の 3 つの場合が排反。
- `card_diag_{three,five,seven}` / `card_one_zero_*` / `card_generic_*` —
  定理 X′ の証明が使うレベル 1 の点の個数を `decide` で検算（$2(\ell-1)$ / $2(\ell-1)$ / $(\ell-1)(\ell-3)$）。
- `card_diag_two` / `card_generic_two` — $\ell=2$ で数え方が壊れること。
- `sum_level_A` — 場合 [A] の総和 $\sum_{m=1}^n S_m=2n\ell^n+2\lambda_0(\ell^n-1)+2n$。
- `sum_level_B` — 場合 [B] の総和（$\varphi_n$ 倍した形のまま）。
- `ordKappa_of_sigma` — $(1.1)$ への代入。
- `cycle19_5_4_example_mismatch` — §1 の誤りの witness。

### 4.3 `IntegrableLattice/TowerTypeCoefficients.lean`（定理 J6・J7・J8）

- `sum_level_stab` / `level_ratio_indep` — 定理 J6（§3）。
- `layer_sum` — 定理 J7 の証明 (b) の層ごとの和。
  人手証明が「$\varphi(\ell^{M'-1-v})\ell^{v+1}=\varphi(\ell^{M'})$ は $v$ に依らない」と述べている
  相殺が、そのまま $s\cdot\varphi$（＝$M'\ell^{M'}$ 項）を生むことが型で見える。
- `sum_mul_pow` — $\sum_{M=1}^nM\ell^M$ の閉形式（定理 J7 (c) と定理 J8 (6) が共用）。
- `J8_direction_sum` / `sum_Theta_J8` / `ordKappa_J8` — 定理 J8 の $\Theta_{M'}$ と閉形式
  $\mathrm{ord}_\ell(\kappa_n)=2n\ell^n+2\ell^n-2$。

**相互検証**: `ordKappa_J8`（step 1 の道具＝定理 J7 の数え方から出る値）と
`theoremJ8_eq_XPrime`（step 2 の定理 X′ に $\Lambda=2$ を入れた値）が一致する。
cycle 19 step 1 §5.6 (a) が主張していた「2 つの step が独立に同じ値へ到達する」が
Lean 上でも成立している。

---

## 5. 形式化しなかったもの（mathlib の欠落か、配線か）

**mathlib に無いと書く前に必ず検索した**（生ログ `lean/logs/mathlib-gap-survey-cycle20.log`。
走査 8264 ファイル、mathlib `520045ab14e2`）。

| 未形式化の主張 | 何が足りないか | 判定 |
|---|---|---|
| 塔の値 $\kappa_n$ の独立計算（定理 X′ の照合の片側） | Kirchhoff の matrix-tree 定理／全域木数の公式。`kirchhoff` は内容・ファイル名とも **0 件**、`spanning tree` の 3 件は全域木の**存在**であって個数の公式ではない | **mathlib の欠落** |
| 定理 X の点ごとの付値（$v_\ell(h^N-1)=\ell^{\nu(N)}/\varphi_m$） | $\mathbb{Q}(\zeta_{\ell^m})$ の $\ell$ の上の素点への配線。`IsCyclotomicExtension` は**実在する** | **配線**（本 step でやっていない） |
| 定理 J7 の主張そのもの（$b=\sum_{P\in S_\infty}j^*(P)$） | $S_\infty$ と $j^*$ は $\mathbb{F}_\ell[[x]]$ での $\psi_j$ の位数で定義される。`PowerSeries.order` は**実在**し、二項冪級数（`Mathlib/RingTheory/PowerSeries/Binomial.lean`、`Mathlib/Analysis/Analytic/Binomial.lean`）も**実在する** | **配線** |
| 命題 J2′ の「破れる $\iff k=2$」 | 2 変数多項式としての $\bar A_2$ と $k=\mathrm{ord}(\bar g)$ の接続。本ファイルは $\bar A_m$ を点ごとの値として扱っている | **配線** |
| $\Theta_{M'}=\beta M'\ell^{M'}+O(\ell^{M'})$ からの係数の読み取り（一般形） | $O$ 記法がそのままでは主張にならない。一般形にするには「$\Theta$ が 4 係数の形に乗る」ことを仮定に出す必要があり、それは report §5.6 (d) が**数値の当てはめ**で確かめている事柄である | **主張の形の問題**（mathlib でも配線でもない） |

**逆に、mathlib に在って使えたもの**: Lucas の定理（`Mathlib/Data/Nat/Choose/Lucas.lean`。
cycle 16 の偽陰性事故を踏まえてファイル名検索も行い、**実在を確認してから使った**）、
`add_pow_char_pow`、`Polynomial.coeff_one_add_X_pow`、`geom_sum_mul`、`Finset.sum_range_reflect`。

---

## 6. 実行した検証（一次情報）

| 検証 | 結果 | ログ |
|---|---|---|
| `lake exe cache get` | `CACHE_EXIT=0` | `lean/logs/cache-get-cycle20.log` |
| `lake build` | `Build completed successfully (8671 jobs).` / `BUILD_EXIT=0`（cycle 19 は 8668 jobs） | `lean/logs/build-cycle20-J.log` |
| `bash lean/scripts/check-no-sorry.sh` | ソース中に `sorry`/`admit` なし。列挙した **156 個**の定理（cycle 19 は 107 個。今回 **49 個**追加）がすべて `sorryAx` 非依存。依存公理は `propext` / `Classical.choice` / `Quot.sound` のみ / `CHECK_EXIT=0` | `lean/logs/check-no-sorry-cycle20.log` |
| mathlib 欠落調査（3 段方式） | §5 の表 | `lean/logs/mathlib-gap-survey-cycle20.log` |
| `npm run check`（構造化 LaTeX） | `CHECK_EXIT=0`（生成物の鮮度・型検査・実行時検証・移行漏れ・負テスト 9 件・実行時検証テスト 13 件） | — |
| `validate-content.ts` | 未解決参照・未解決 targets なし | — |
| `verify-check-linkage.ts` | 参照されている対応はすべて生きている（SageMath 39 件、Lean 参照は 46 件 → **67 件**に増加） | — |

本文側の変更は 3 箇所（いずれも最小限）:
(a) `008_theta_padic.ts` の (J1) に $A_1\equiv0$ の仮定と反例を追記、
(b) 同ブロックに `lean:` の対応を追加、
(c) `005b_theta_infinity.ts` に `lean:` の対応を追加。

---

## 7. 本 step で自分が犯した誤り（隠さず記録する）

1. **`J6_no_n_pow_term` の数値を最初に間違えた。** 型 II の式の値を $\ell=3,n=2$ で
   $12$ と書いたが、最初に書いた式 $2\cdot3^2-2\cdot2-2+2$ は $14$ である。
   `norm_num` が `False` を残して落ちたので気づいた。式を $2\cdot3^2-2\cdot2-2$ に直した。
   **Lean は主張の検算だけでなく、report を書く自分の算術の検算にもなっている。**
2. **証明の骨組みを作る途中で `sorry` を 2 箇所置いた**（`Abar_shift_pow_succ` と `Bbar_diag`）。
   いずれも同じセッション内で埋めており、コミットには残っていない
   （`check-no-sorry.sh` の grep 段で残存が検出される仕組みなので、残っていれば必ず落ちる）。
3. **`PowerSeries.order` が mathlib に在ると書きかけて、検索前だったので止めた。**
   §5 に書く前に `mathlib-gap-survey-cycle20.log` へ追加調査を走らせ、実在を確認してから書いた
   （cycle 16 の偽陰性事故と対称な、「在ると決めつける」側の事故を防ぐため）。

---

## 8. 新規性

**主張しない。** 本 step は既存の主張の検算であり、数学的に新しい内容は
§1 の誤りの指摘（既存主張の訂正）と §2・§3 の仮定の整理だけである。
