# w* を適合基底（Smith 標準形）で書けるか——「素材が無い」という判定の検証

作成: 2026-08-04（cycle 29 step 3）。
対象: 命題 C′・命題 C″・命題 W\* が共有する壁とされていた「整数行列の単因子（Smith 標準形）」。

## この step が答えを出した問い

cycle 29 step 1 の仕分け（`cycle29_ops_formalization_triage.md`）は、この 3 件の残りを
「素材が無い」と判定した。根拠は「mathlib の `Module.Basis.SmithNormalForm` は
部分加群の基底の形であって行列の単因子ではない」というものである。

この判定が正しいかを一次情報で確かめ、正しくなければ書けるところまで書く、というのが本 step である。

## 実測（一次情報）

走査した mathlib は `520045ab14`（`Mathlib/**/*.lean` 8264 ファイル）。

1. **適合基底は在る。** `Mathlib/LinearAlgebra/FreeModule/PID.lean` に
   `Ideal.smithNormalForm`（668 行）、`Ideal.exists_smith_normal_form`、`Ideal.ringBasis`、
   `Ideal.selfBasis`、`Ideal.smithCoeffs`、`Ideal.selfBasis_def`、`Ideal.smithCoeffs_ne_zero` が実在する。
   仮定は「$S$ が PID $R$ の有限次拡大で $R$ 加群として自由、$I\neq\bot$」であり、
   本論文の $A=\mathbb{Z}[x]/(\rho)$ と $I=\eta A$ はこれを満たす。
   より一般の `Submodule.exists_smith_normal_form_of_rank_eq`（同ファイル 578 行）もある。
2. **整除の鎖は無い。** `a i ∣ a (i+1)` の形の補題は 0 件（`smithCoeffs` に整除を述べた補題は 1 つも無い）。
   したがって「最大単因子」という順序づけられた不変量を直接取ることはできない。
   **step 1 の「無い」の中身はここだけが正しかった。**
3. **しかし $w^*$ に鎖は要らない。** 適合基底で書けば
   $p^jA\subseteq\eta A$（$p$ の外で）は「すべての $i$ で $a_i\mid p^j$（$p$ の外で）」と同値なので、
   $w^*=\max_i v_p(a_i)$ である。$\max$ は順序を持たない族の上で取れるので、鎖の欠落は障害にならない。
   **これを Lean で証明した**（`isLeast_isPLevel` / `isLeast_isPLevel_ideal`）。
   よって **step 1 の「素材が無い」という判定は覆った。**
4. 双対の段に使う素材も在る。`Module.Basis.traceDual`、`Module.Basis.traceDual_powerBasis_eq`
   （＝Euler の双対基底公式。`Mathlib/RingTheory/Trace/Basic.lean:610`）、
   `Module.Basis.trace_traceDual_mul`、`Algebra.discr_powerBasis_eq_norm`
   （`Mathlib/RingTheory/Discriminant.lean:201`）、`Algebra.norm_eq_matrix_det`、
   `Algebra.leftMulMatrix_eq_repr_mul`。**ただしどれも体の上でしか無い。**

## 形式化したもの（`lean/IntegrableLattice/WStarElementaryDivisors.lean`、14 定理 5 定義）

| 何を | Lean |
| --- | --- |
| $A_{(p)}$ への所属を局所化を作らずに書く（$p$ と素な整数を掛ければ入る） | `MemAwayFrom` / `IsPLevel` / `isPLevel_mono` |
| $a\mid m\,p^j$ なる $p$ と素な $m$ が取れる $\iff v_p(a)\le j$ | `exists_dvd_mul_pow_iff` |
| 適合基底での所属判定（座標が $a_i$ で割れること） | `mem_iff_dvd_repr` |
| **$w^*$ の定義と、それが最小元であること** | `wStarOfCoeffs` / `isLeast_isPLevel` |
| $w^*=0$ の判定 | `wStarOfCoeffs_eq_zero_iff` |
| イデアルへの特殊化と、最小を取る集合が空でないこと | `isLeast_isPLevel_ideal` / `exists_isPLevel_ideal` |
| 可逆な取り替えで像に対する $p$ 進の条件が変わらない | `isPLevel_range_comp` |
| 重み付き Gram 行列＝トレース形式の Gram 行列 × $\mu$ 倍の行列 | `weightedGram` / `weightedGram_eq` |
| **本文の $\det G=\pm N_{A/\mathbb{Q}}(\eta)$** と $\det G\neq0$ | `det_weightedGram` / `det_weightedGram_ne_zero` |
| **Euler の双対基底公式**: $\operatorname{Tr}(c_i w)=[\theta^i](\rho'(\theta)w)$ | `trace_coeff_minpolyDiv_mul` |
| **双対の段の行列版** $C\,G=M_\eta$ と $(\det C)^2=1$ | `eulerMatrix` / `eulerMatrix_mul_weightedGram` / `det_eulerMatrix_sq` |

### 形式化して分かったこと

- **$w^*$ の段に環の構造は要らない。** 効いているのは「有限自由 $\mathbb{Z}$ 加群と、適合基底を持つ
  部分加群」だけで、$A$ が環であることも $\eta A$ がイデアルであることも使わない。
  イデアルの場合はそこへ `Ideal.ringBasis` などを渡すだけで出る。過剰仮定の 1 件として記録する
  （cycle 27・28・29 step 1 に続き **4 サイクル連続**で「仮定は主張でなく文脈が要求したもの」が出た）。
- **$\mathbb{R}$ も $p$ 進整数環も現れない。** $w^*$ は $\mathbb{N}$ の元で、判定は整数の割り切れと
  素因数分解の指数比較だけで閉じている（本文が「実数の切り上げではない」と書いていることの、
  もう一段前の部分にあたる）。
- **$\det C=\pm1$ は独立に証明しなくてよい。** $C\,G=M_\eta$ で $\mu=1$ と置き、
  判別式が $\rho'(\theta)$ のノルムに等しいこと（`discr_powerBasis_eq_norm`）と
  判別式が $0$ でないこと（`discr_not_zero_of_basis`）を合わせると $(\det C)^2=1$ が出る。
  三角性を示す必要は無かった。

## 届かなかったところ（命題が「完了」へ動かなかった理由）

**残り 19 件は 19 件のままである。** 命題 W\* は依然として「部分的」で、残っているのは次の 2 つ。
どちらも mathlib の欠落ではなく、こちらが書いていないだけである。

1. **$C$ と $G$ の整数への降下。** $C\,G=M_\eta$ と $(\det C)^2=1$ は体 $K=\mathbb{Q}$ の上の等式である。
   人手証明が使うのは「$C\in GL_r(\mathbb{Z})$ なので $\operatorname{coker}(G)\cong\operatorname{coker}(M_\eta)=A/\eta A$」
   という整数の言明で、そのためには (a) $C$ の成分が整数であること
   （$\rho\in\mathbb{Z}[x]$ がモニックなので `coeff_minpolyDiv` の漸化式から帰納法で出るはず）と、
   (b) 行列の像と $\eta A$ を基底で同一視する配線が要る。
2. **$\rho$ が可約な場合。** 上の第 2 段・第 3 段は `PowerBasis K L`（$L$ は体）を使っており、
   $\rho$ が既約な場合しか覆っていない。本文の $\rho=\mathrm{rad}(\chi_T)$ は一般には可約で、
   そのとき $A\otimes\mathbb{Q}$ は体でなく体の積である。
   mathlib のトレース双対（`Module.Basis.traceDual`）は体の上にしか無い。

命題 C′・C″ については、$w^*$ の定義が入ったことで壁の性質が変わった——
残っているのは「$w^*$ を Gram 行列の側で定義したものと、$A/\eta A$ の側で定義したものの同一視」
（上の 1 と同じ）と、命題 C″ の (1)(3) をその $w^*$ へ結ぶ段である。

## 検査 M（$\min$ / $\max$ の空でなさ）

裏が取れていなかった 4 件（すべて命題 W\*）のうち **3 件の裏が取れた**——
$\min\{j\ge0:\ p^j\eta^{-1}\in A_{(p)}\}$ とその言い換え 2 件は `exists_isPLevel_ideal` が空でないことを言う。
残る 1 件は $\max_{\mathfrak p\mid p}$（$p$ の上に素イデアルが少なくとも 1 つあること）で、
これは書いていない。裏取りは **13/17 → 16/17**。

## 自分が犯した誤り（記録）

1. **mathlib に無い補題名を 1 つ書いた**（`Int.Prime.dvd_finset_prod_iff`）。
   実在するのは `Prime.dvd_finsetProd_iff` である。ビルドで落ちて直した。
   3 サイクル連続で再発していた形と同じで、**今回も再発した。**
   ただし今回は「在るはず」と書いたのは 1 件で、他の名前
   （`Ideal.smithCoeffs` 系・`traceDual` 系・`discr_powerBasis_eq_norm` 系）は
   すべて書く前に grep で実在と型を確認している。
2. **`Module` 名前空間を開かずに `Basis` と書いた。** この mathlib では `Module.Basis` である。
3. **ℤ 加群のインスタンスの取り違えで 3 回落とした。**
   `[AddCommGroup M] [Module ℤ M]` を両方書くと `•` が `ZSMul` と `Module` の 2 通りに解釈され、
   `Submodule ℤ M` の側と型が合わなくなる。一般の可換環 `R` で書ける補題は `R` で書き、
   ℤ 固有の部分だけを分けることで解消した。
4. **`rw` の向きを確かめずに書いて motive が壊れた**（`x ∈ N` の証明が `x` に依存しているので
   `x` を書き換えられない）。`congrArg` で回避した。

## この作業の限界（機械で確かめられていないこと）

- **上の「届かなかったところ」の 1 は、書けば通る見込みだという判断であって、書いて通したものではない。**
  cycle 29 step 1 の仕分けが「配線」と判定したものを実際に書いたら
  `PropV.lean` の実態が違っていた前例があるので、この見込みも同じ性質の判断である。
- **「$\rho$ が可約な場合は mathlib に素材が無い」の根拠は、トレース双対の宣言が体を要求している
  という 1 点である。** 別の道（成分ごとの分解、あるいは Euler の等式を係数の帰納法で直接示す）で
  回避できないことを示したわけではない。
- 本文の $w^*$ は Gram 行列の最大単因子として定義されており、
  **本ファイルの $w^*$ がそれと同じものであることは、上の 1 が埋まるまで機械検証されていない。**
  現在あるのは、体の上での行列の等式（$C\,G=M_\eta$）と、整数側での最小元の特徴づけの 2 つが
  別々に立っている状態である。
