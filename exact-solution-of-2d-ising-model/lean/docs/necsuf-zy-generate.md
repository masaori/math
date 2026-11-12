# `<Z_Y_generate_algebra>` の必要十分版 — 何が効いていて、何が効いていなかったか

対象の人手証明: `parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ`
（ラベル `<Z_Y_generate_algebra>`）

| | ファイル | 主要定理 |
| --- | --- | --- |
| 具体版 | `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimZYGenerateAlgebra.lean` | `Ising2D.Z_Y_generate_algebra` |
| 必要十分版 | `Ising2D/NecSuf/GeneratedByBasis.lean` | `NecSuf.string_mem` / `NecSuf.local_mem` / `NecSuf.xl_mul_string_comm` / `NecSuf.string_mul_self` / `NecSuf.string_eq_finProdLeft` / `NecSuf.map_mem_of_mulSingle_mem` / `NecSuf.eq_top_of_span_eq_top` |
| 具体版の再導出 | `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimZYGenerateAlgebraFromNecSuf.lean` | `Ising2D.Z_Y_generate_algebra_of_necSuf` |

この文書は、必要十分版を実際に書いて `lake build` を通した結果として判明したことだけを書く
（推測は書かない。根拠はすべて上記 3 ファイルの仮定と証明本体である）。

---

## 1. 必要十分版の仮定（＝本当に必要だったもの）

### (a) 「全体を張る集合を全部含む部分多元環は全体」 — `NecSuf.eq_top_of_span_eq_top`

仮定は `[CommSemiring R] [Semiring A] [Algebra R A]` と、`R`-加群として全体を張る集合 `s` だけ
（基底である必要は無い）。証明は `Submodule.span_le` しか使っていない。

**効いているのは「部分多元環は部分加群でもある」ことだけ**である。
導出では `s` を `𝓑^{⊠M}` の元の集合とし、全体を張ることを `Basis.span_eq` で渡す。

### (b) 「サイトごとの元の積は部分半群に属する」 — `NecSuf.prefixProduct_eq_and_mem`・`NecSuf.map_mem_of_mulSingle_mem`

人手 Step 3 後半の `Q_1 := E_1`・`Q_{s+1} := Q_sE_{s+1}` の帰納法（`Q_s = e_1 ⊠ ⋯ ⊠ e_s ⊠ I ⊠ ⋯ ⊠ I` かつ `Q_s ∈ 𝒜`）を、
具体版 `Ising2D.siteFactorPrefixProduct_eq_and_mem` と同じ段の並びで回す。仮定は

* 添字は `Fin n` で `0 < n`（`Q_1` から始めるため。`n = 0` では帰納法を始められない）、
* 各サイトの `N i` は `MulOneClass`（単位元が両側の単位元であること。サイトごとに違ってよい）、
* 目標の `A` は積を持つだけ（結合律も単位元も不要）、
* **積を保つ写像** `φ : (∀ i, N i) →ₙ* A`、
* 部分半群 `S` と、各 `k` について `φ (Pi.mulSingle k (x k)) ∈ S`

だけ。

**効いているのは `φ` が積を保つこと（具体版の `kronecker_product_rule` (1)）と、各サイトの単位元の両側の単位律だけ**で、
クロネッカー積の成分公式（`siteProd_apply`）も、異サイト可換性（`siteOp_mul_comm`）も、`φ` が単位元を保つことも使っていない。
具体版の帰納法は行列の性質を一段の 6 行（`kronecker_product_rule` (1)・右単位・左単位 2 回）でしか参照していなかった、
ということが必要十分版で確認できた。

添字の順序は使う。人手の `Q_s` が第 `1` から第 `s` 因子を左から順に掛けた積だからである。
主張だけなら任意の有限添字で成り立つ（有限集合の帰納法）が、それは人手と別の手順なので置かない。

### (c) Step 2（Jordan–Wigner 文字列の帰納法） — `NecSuf.string_mem` / `NecSuf.local_mem`

手順は具体版（`sigma_mem_adjoin_all`・`sigma_mem_adjoin_first_site`・`sigma_mem_adjoin_of_previous_sigmaX`・`sigmaXPrefixProduct_mem_adjoin`）と同じで、外側を累積帰納法（仮定は `j < n` の `xl j ∈ S`）にし、`n = 0` は `zl 0 = z 0`・`yl 0 = y 0`（`p 0 = 1`）を読む枝、`n ≥ 1` はその中で `p n ∈ S` を `r` の帰納法で出す（`string_mem_of_previous`・`local_mem_of_previous`・`local_mem`）。`string_mem_of_previous` は `S` が部分モノイドであることだけを使う。

**抽象化できた。** 仮定は次の形の漸化式と分解だけである（`R` は任意の可換半環）。

```
p 0 = 1
zl n = p n * z n          -- σ^z_n = P_n Z_n
yl n = p n * y n          -- σ^y_n = P_n Y_n
xl n = r • (yl n * zl n)  -- σ^x_n = -√-1 σ^y_n σ^z_n
p (n+1) = p n * xl n      -- P_{n+1} = P_n σ^x_n
z n ∈ S, y n ∈ S          -- 生成元は 𝒜 に入る
```

結論は `p n ∈ S`（`n ≤ N`）と `zl n, yl n, xl n ∈ S`（`n < N`）。

ここで判明したこと:

* **係数 `-√-1` の値は一切効いていない。** 必要十分版では `r : R` という名前しか持たず、
  `Subalgebra.smul_mem` へそのまま渡されるだけである。`r^2 = -1` も `r ≠ 0` も使わない。
  つまり Step 2 に必要なのは「部分多元環がスカラー倍で閉じている」ことだけで、
  係数が複素数であることでも、体であることでもない。
* **`P_m P_m = I`（文字列の対合性）は Step 2 の帰納法には効いていない。** 具体版は
  対合性を使って `Z_m = P_m σ^z_m` を `σ^z_m = P_m Z_m` へ裏返すが、
  裏返した後の形（`zl n = p n * z n`）を仮定にとれば、以降どこにも対合性は現れない。
  対合性が効くのは「生成元の分解を局所元の分解へ変換する」1 箇所だけである。
* **反交換関係は Step 2 の主張には全く効いていない。** 必要十分版の仮定に反交換関係は無い。

### (d) Step 2 の準備（可換の式と二乗の式） — `NecSuf.xl_mul_string_comm` / `NecSuf.string_mul_self`

人手 Step 2 の `P_0 := I`・`P_r := P_{r-1}σ_r^x` について、可換の式 `σ_k^xP_r = P_rσ_k^x`（`r < k`）と
二乗の式 `P_rP_r = I` を同じ帰納法で示す（具体版は `Ising2D.sigmaX_mul_sigmaXPrefixProduct_comm`・`Ising2D.sigmaXPrefixProduct_mul_self`）。
仮定は次だけである。

```
[Monoid A]
p 0 = 1
p (n+1) = p n * x n                       -- P_{n+1} = P_n σ^x_{n+1}（0 始まり）
x n * x n = 1                             -- σ^xσ^x = I
n < k → x k * x n = x n * x k             -- 相異なる番号どうしの可換性（等式が対称なので n < k の形で書く）
```

* 使う代数の構造は結合則と単位元の両側の単位性だけで、加法・スカラー倍・`A` の乗法の可換性は使わない。
* `x n * x n = 1` も可換性も削れない（ファイルの節の冒頭に反例を書いた）。
* 結合則も削れない。`Monoid` を単位的マグマ `MulOneClass` に替えると、ほかの仮定を全部残しても両方の主張が偽になる。
  反例は 6 元の単位的マグマ `NecSuf.SixElementUnitalMagma`（`N = 3`、`x 0, x 1, x 2 = a, b, c`、`p 2 = d`、`c d = e ≠ 1 = d c`、`d d = e`）で、
  `NecSuf.xl_mul_string_comm_false_without_assoc`・`NecSuf.string_mul_self_false_without_assoc` が、主張の `Monoid` を `MulOneClass` に替えた全称命題の否定を示す。

### (e) Step 2 の準備（積の表示） — `NecSuf.string_eq_finProdLeft`

人手 Step 2 の積の表示 `P_r = ∏_{j=1}^{r}σ_j^x`（`r ≥ 1`）を同じ帰納法で示す（具体版は `Ising2D.sigmaXPrefixProduct_eq_finiteMatrixProduct`、
導出は `Ising2D.sigmaXPrefixProduct_eq_finiteMatrixProduct_of_necSuf`）。仮定は次だけである。

```
[Mul A] [One A]
p 0 = 1
p (n+1) = p n * x n                       -- P_{n+1} = P_n σ^x_{n+1}（0 始まり）
1 * x 0 = x 0                             -- r = 1 の段の左の単位元（A → σ_1^x）
```

* 結合則は使わない（漸化式と有限積の定義はどちらも右から 1 つずつ掛ける）。
* `1 * x 0 = x 0` は主張の `r = 0`（人手の `r = 1`）の場合そのものなので削れない。
* `N = 0` のときは主張が空で、`1 * x 0 = x 0` も使わない。

---

## 2. 具体版で埋める必要が残ったもの（＝本当に複素 2×2 行列が要るところ）

`ClaimZYGenerateAlgebraFromNecSuf.lean` で必要十分版に渡すために補ったのは 3 つだけである。

1. **`𝓑^{⊠M}` が全体を張ること `span_kroneckerFamily_eq_top_of_necSuf pauliFamily pauliFamily_spans`**:
   `𝓑 = {I, σ^x, σ^y, σ^z}` が `Mat(2, ℂ)` を張ること（`Ising2D.pauliFamily_spans`。係数は
   `Ising2D.matrix_two_decomp`（原文 Step 3 の展開の式。成分ごとの鎖は `pauliDecompRhs_apply_00`〜`_11`））と、
   `<kronecker_family_of_spanning_family_spans>` を `𝓑` に当てた `𝓑^{⊠M}` が `Mat(2^M, ℂ)` を張ること
   （その必要十分版 `NecSuf.mem_familyCombinations_of_spanning` からの導出。`lean/docs/` には別の記録を置かず、必要十分版のファイル冒頭に書いた）。
   `𝓑` が張ることには **2×2 であることと係数が ℂ であることが本質的**（`1/2` と `√-1` を使う）。
   クロネッカー積の族が張ることは、`Mat(2, ℂ)` を張る任意の族で成り立つ。
2. **`Ising2D.siteProdHom`**: `siteProd` を積を保つ写像（`MulHom`）として束ねたもの。
   材料は既存の `siteProd_mul` だけ。`M = 0`（人手に現れない場合）は必要十分版の `0 < n` を満たさないので、
   導出の `siteProd_mem_of_necSuf` は具体版と同じく `siteProd_one` と (ii) で別に閉じる。
3. **`Ising2D.siteOp_pauliFamily_mem_adjoin_of_necSuf`**: 各 `E_k = siteOp k e_k`（`e_k ∈ 𝓑`）が `𝒜` に入ること。
   `e_k = I` なら `siteOp_one`、`e_k = σ^x, σ^y, σ^z` なら Step 2 の必要十分版の結論。

言い換えると、原文の証明のうち **複素 2×2 行列に依存しているのは「1 サイトで張る族の取り方」だけ**であり、
「張る族のクロネッカー積の族が張ること」、Step 2 の帰納法、Step 3 の
「張る集合を含むから全体」「`e_1 ⊠ ⋯ ⊠ e_M` は `E_k` の積で作れる」はいずれも一般論である。

---

## 3. 具体版が過剰な構造を要求していないかの検査（README 4 節の目的）

必要十分版を書く過程で、具体版が不要な性質に依存している箇所は、下の 1 点目（基底であることを経由していた。2026-11-12 に直した）を除いて見つからなかった。
具体版 `Z_Y_generate_algebra` の各ステップは、必要十分版の仮定へ対応する
（ステップの対応表は具体版 `ClaimZYGenerateAlgebra.lean` の冒頭コメント）。

次の 3 点は「必要十分版のほうが仮定が弱い」ことが分かった（1 点目は 2026-11-12 に具体版・人手を直したので、いまは差が無い）。

* 具体版の Step 3 は人手どおり `𝓑^{⊠M}` が**基底**であることを経由していた（`finrank_mat2_eq_four`・
  `basisOfTopLeSpanOfCardEqFinrank`・`Basis.piTensorProduct`）。しかし必要十分版 `NecSuf.eq_top_of_span_eq_top` が
  使うのは、その族が全体を**張る**ことだけである。2026-11-12 に人手 Step 3 を「張る」で結ぶ形へ直し
  （`<kronecker_family_of_spanning_family_spans>` を足して引く）、具体版も同じ形にした。

* 具体版 `Ising2D.siteProd_mem` は `Subalgebra ℂ (TensorPow M)` を相手にしているが、
  必要十分版 `NecSuf.map_mem_of_mulSingle_mem` は**部分半群**で足りる
  （加法もスカラー倍も単位元も不要）。
* 具体版 Step 2 は `sigmaXPrefixProduct_mul_self`（`P_m P_m = I`）を帰納法の中で使う形に見えるが、
  実際には分解 `σ^z_m = P_m Z_m` を作る前処理でしか使っておらず、
  帰納法本体は対合性なしで回る。その `P_m P_m = I` 自体に効くのは (d) の仮定だけである。

---

## 4. 抽象化できなかった部分と、その理由

* **`matrix_two_decomp`（1 サイトの分解）**: これは `Mat(2, ℂ)` の具体的な事実であり、
  抽象化すると「4 元の族が張る」という内容の無い主張になる。必要十分版へは
  張ることを述べる `pauliFamily_spans` の形で渡すのが限界で、その証明は具体計算のまま残る。

---

## 5. 検証

`exact-solution-of-2d-ising-model/lean` で以下を実行して確認する。

```
lake build
bash scripts/check-no-sorry.sh
```

実行結果（2026-11-12 時点、`lake build` は 3446 ジョブすべて成功、`check-no-sorry.sh` は exit 0）:

```
'Ising2D.NecSuf.string_mem_of_previous' does not depend on any axioms
'Ising2D.NecSuf.local_mem_of_previous' does not depend on any axioms
'Ising2D.NecSuf.local_mem' does not depend on any axioms
'Ising2D.NecSuf.string_mem' does not depend on any axioms
'Ising2D.NecSuf.xl_mul_string_comm' does not depend on any axioms
'Ising2D.NecSuf.string_mul_self' does not depend on any axioms
'Ising2D.NecSuf.string_eq_finProdLeft' depends on axioms: [propext]
'Ising2D.NecSuf.map_mem_of_mulSingle_mem' depends on axioms: [propext, Quot.sound]
'Ising2D.Z_Y_generate_algebra_of_necSuf' depends on axioms: [propext, Classical.choice, Quot.sound]
'Ising2D.NecSuf.xl_mul_string_comm_false_without_assoc' depends on axioms: [propext]
'Ising2D.NecSuf.string_mul_self_false_without_assoc' depends on axioms: [propext]
```

（Step 2 の 6 行は 2026-11-12 に、累積帰納法の三段・可換の式・二乗の式へ組み直した後に `#print axioms` で取った出力。
`map_mem_of_mulSingle_mem` の行は同じ日に `P_s`（いまの `Q_s`）の帰納法へ書き直した後の出力。結合則を外した反例の 2 行は同じ日に反例を足した後の出力で、`propext` は積の表を `decide` で確かめる段から入る。`string_eq_finProdLeft` の行は同じ日に積の表示を足した後の出力で、
`propext` は有限積の初項・漸化式を右辺から左辺へ読む段の `rw` から入る。選択公理は使わない。）

Step 2 の必要十分版（`string_mem_of_previous` / `local_mem_of_previous` / `local_mem` / `string_mem` / `xl_mul_string_comm` / `string_mul_self`）が**公理に一切依存しない**ことは、
上の「Step 2 に効いているのは漸化式と分解の形だけ」という主張の独立した裏づけになる
（選択公理も命題外延性も使わずに証明が閉じている）。
`map_mem_of_mulSingle_mem` が `Classical.choice` を使わないことも同様で、
`Q_s` の帰納法と、`φ` が積を保つことだけで閉じていることを示している。

`scripts/check-no-sorry.sh` の `targets` には本作業で追加した主要宣言
（`NecSuf.string_mem_of_previous`, `NecSuf.local_mem_of_previous`, `NecSuf.string_mem`, `NecSuf.local_mem`, `NecSuf.xl_mul_string_comm`, `NecSuf.string_mul_self`, `NecSuf.prefixProduct_eq_and_mem`, `NecSuf.map_mem_of_mulSingle_mem`,
`NecSuf.eq_top_of_span_eq_top`, `Ising2D.Z_Y_generate_algebra_of_necSuf` ほか）を登録済み。
