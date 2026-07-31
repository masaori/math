# `<Z_Y_generate_algebra>` の抽象版 — 何が効いていて、何が効いていなかったか

対象の人手証明: `parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ`
（ラベル `<Z_Y_generate_algebra>`）

| | ファイル | 主要定理 |
| --- | --- | --- |
| 具体版 | `Ising2D/Part004/Claim014_ZYGenerateAlgebra.lean` | `Ising2D.Z_Y_generate_algebra` |
| 抽象版 | `Ising2D/Abstract/GeneratedByBasis.lean` | `Abstract.string_mem` / `Abstract.local_mem` / `Abstract.map_mem_of_mulSingle_mem` / `Abstract.eq_top_of_basis_mem` ほか |
| 具体版の再導出 | `Ising2D/Part004/Claim014_ZYGenerateAlgebraAbstract.lean` | `Ising2D.Z_Y_generate_algebra_of_abstract` |

この文書は、抽象版を実際に書いて `lake build` を通した結果として判明したことだけを書く
（推測は書かない。根拠はすべて上記 3 ファイルの仮定と証明本体である）。

---

## 1. 抽象版の仮定（＝本当に必要だったもの）

### (a) 「基底を全部含む部分多元環は全体」 — `Abstract.eq_top_of_basis_mem`

仮定は `[CommSemiring R] [Semiring A] [Algebra R A]` と `Basis ι R A` だけ。
証明は `Submodule.span_le` と `Basis.span_eq` の 2 つしか使っていない。

**効いているのは「部分多元環は部分加群でもある」ことだけ**である。
より原型的な形は `Abstract.eq_top_of_span_eq_top`（基底である必要すらなく、
`R`-加群として全体を張る集合を含めばよい）。

### (b) 「サイトごとの元の積は部分モノイドに属する」 — `Abstract.map_mem_of_mulSingle_mem`

仮定は

* 添字型 `ι` が有限で等号判定可能、
* 各サイトのモノイド `N i`（サイトごとに違ってよい）、
* 目標のモノイド `A`（可換性は不要）、
* **モノイド準同型** `φ : (∀ i, N i) →* A`、
* 部分モノイド `S` と、各 `k` について `φ (Pi.mulSingle k (x k)) ∈ S`

だけ。証明は `x = Finset.univ.piecewise x 1` と有限集合の帰納法である。

**効いているのは `φ` が単位元と積を保つことだけ**で、クロネッカー積の成分公式
（`siteProd_apply`）も、異サイト可換性（`siteOp_mul_comm`）も使っていない。
具体版 `Ising2D.siteProd_mem` は同じ帰納法を `TensorPow M` の中で直接回しているが、
その帰納法は行列の性質を一切参照していなかった、ということが抽象版で確認できた。

サイト間の可換性が要らない理由も抽象版から読める。分解 `x = ∏_k mulSingle k (x k)` は
**直積モノイドの中の等式**であり、`mulSingle` 同士は台が交わらないので順序に依らない。
`A` 側での可換性はどこにも要求されない。

### (c) Step 2（Jordan–Wigner 文字列の帰納法） — `Abstract.string_mem` / `Abstract.local_mem`

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

* **係数 `-√-1` の値は一切効いていない。** 抽象版では `r : R` という名前しか持たず、
  `Subalgebra.smul_mem` へそのまま渡されるだけである。`r^2 = -1` も `r ≠ 0` も使わない。
  つまり Step 2 に必要なのは「部分多元環がスカラー倍で閉じている」ことだけで、
  係数が複素数であることでも、体であることでもない。
* **`P_m P_m = I`（文字列の対合性）は Step 2 の帰納法には効いていない。** 具体版は
  対合性を使って `Z_m = P_m σ^z_m` を `σ^z_m = P_m Z_m` へ裏返すが、
  裏返した後の形（`zl n = p n * z n`）を仮定にとれば、以降どこにも対合性は現れない。
  対合性が効くのは「生成元の分解を局所元の分解へ変換する」1 箇所だけである。
* **反交換関係は Step 2 の主張には全く効いていない。** 抽象版の仮定に反交換関係は無い。

---

## 2. 具体版で埋める必要が残ったもの（＝本当に複素 2×2 行列が要るところ）

`Claim014_ZYGenerateAlgebraAbstract.lean` で抽象版に渡すために補ったのは 3 つだけである。

1. **`Ising2D.span_pauli_eq_top`**:
   `{I, σ^x, σ^y, σ^z}` が `Mat(2, ℂ)` を ℂ-加群として張る。
   中身は既存の `Ising2D.matrix_two_decomp`（原文 Step 3 の成分比較の式）そのもの。
   ここは **2×2 であることと係数が ℂ であることが本質的**（`1/2` と `√-1` を使う）。
2. **`Ising2D.siteProdHom`**: `siteProd` を `MonoidHom` として束ねたもの。
   材料は既存の `siteProd_one` と `siteProd_mul` だけ。
3. **`Ising2D.E_eq_siteProd`（既存）**: 行列単位 `E_{IJ}` が各サイトの行列単位のテンソル積であること。
   ここはクロネッカー積の成分公式が本質的。

言い換えると、原文の証明のうち **複素 2×2 行列に依存しているのは「1 サイトの基底の取り方」と
「行列単位がテンソル積に分解すること」だけ**であり、Step 2 の帰納法と Step 3 の
「基底を含むから全体」「単項テンソルは積で作れる」はいずれも一般論である。

---

## 3. 具体版が過剰な構造を要求していないかの検査（README 4 節の目的）

抽象版を書く過程で、具体版が不要な性質に依存している箇所は見つからなかった。
具体版 `Z_Y_generate_algebra` の各ステップは、抽象版の仮定へ 1 対 1 に対応する
（対応表は `Claim014_ZYGenerateAlgebraAbstract.lean` の冒頭コメント）。

ただし次の 2 点は「抽象版のほうが仮定が弱い」ことが分かった。

* 具体版 `Ising2D.siteProd_mem` は `Subalgebra ℂ (TensorPow M)` を相手にしているが、
  抽象版 `Abstract.map_mem_of_mulSingle_mem` は**部分モノイド**で足りる
  （加法もスカラー倍も不要）。
* 具体版 Step 2 は `xString_mul_self`（`P_m P_m = I`）を帰納法の中で使う形に見えるが、
  実際には分解 `σ^z_m = P_m Z_m` を作る前処理でしか使っておらず、
  帰納法本体は対合性なしで回る。

---

## 4. 抽象化できなかった部分と、その理由

* **`matrix_two_decomp`（1 サイトの基底分解）**: これは `Mat(2, ℂ)` の具体的な事実であり、
  抽象化すると「4 次元代数に基底がある」という内容の無い主張になる。抽象版へは
  「生成系が全体を張る」という形（`span_pauli_eq_top`）で渡すのが限界で、
  その証明は具体計算のまま残る。
* **`E_eq_siteProd`（行列単位のテンソル分解）**: クロネッカー積の成分が因子の成分の積である、
  という表現の具体的な性質。抽象テンソル積の一般論へ持ち上げれば「基底のテンソル積は基底」に
  なるが、それは README 2 節で本文に持ち込まないと決めた道具であり、
  Lean の抽象版としても `Abstract/MatrixUnits.lean` 側の話題になる。ここでは分離せず具体版を再利用した。

---

## 5. 検証

`exact-solution-of-2d-ising-model/lean` で以下を実行して確認する。

```
lake build
bash scripts/check-no-sorry.sh
```

実行結果（2026-07-31 時点、`lake build` は 2990 ジョブすべて成功、`check-no-sorry.sh` は exit 0）:

```
'Ising2D.Abstract.string_mem' does not depend on any axioms
'Ising2D.Abstract.local_mem' does not depend on any axioms
'Ising2D.Abstract.map_mem_of_mulSingle_mem' depends on axioms: [propext, Quot.sound]
'Ising2D.Abstract.eq_top_of_basis_mem' depends on axioms: [propext, Classical.choice, Quot.sound]
'Ising2D.Z_Y_generate_algebra_of_abstract' depends on axioms: [propext, Classical.choice, Quot.sound]
```

Step 2 の抽象版（`string_mem` / `local_mem`）が**公理に一切依存しない**ことは、
上の「Step 2 に効いているのは漸化式と分解の形だけ」という主張の独立した裏づけになる
（選択公理も命題外延性も使わずに証明が閉じている）。
`map_mem_of_mulSingle_mem` が `Classical.choice` を使わないことも同様で、
有限集合の帰納法と準同型性だけで閉じていることを示している。

`scripts/check-no-sorry.sh` の `targets` には本作業で追加した主要宣言
（`Abstract.string_mem`, `Abstract.local_mem`, `Abstract.map_mem_of_mulSingle_mem`,
`Abstract.eq_top_of_basis_mem`, `Ising2D.Z_Y_generate_algebra_of_abstract` ほか）を登録済み。
