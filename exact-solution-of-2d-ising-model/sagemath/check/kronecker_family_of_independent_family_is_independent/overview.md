# SageMath Check: kronecker_family_of_independent_family_is_independent

## 対象

**対象ラベル**: `kronecker_family_of_independent_family_is_independent` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_kronecker_family_of_independent_family_is_independent`（線型独立な族のクロネッカー積の族は線型独立）
- 範囲: 仮定（`b_1,…,b_4` が線型独立）、準備 (a) の `P^{(s)}_q` と (R)（`s ≥ 2` の 3 行の鎖と `s = 1` の 4 行の鎖）、準備 (b) の `χ^{(s)}_q`、
  Step 1 の 8 行の鎖、Step 2 の (2a) の 11 行の鎖・(2b) の δ の 2 行の鎖と `b_{π(q)_s}` の 3 行の鎖と `B` の 6 行の鎖・(2d) の 6 行の鎖、
  Step 4 の `E(s)` と三つの場合の鎖、Step 5 の `q ≠ q_0` の 3 行の鎖と `d_{q_0}` の 6 行の鎖、主張（`(F_q)` の線型独立性）。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 仮定・準備・Step 1〜5・主張 | `check_proof_lines.sage` | 線型独立な族 2 つ（Pauli 族 `{I,σ^x,σ^y,σ^z}` と、別の線型独立な族）と `M = 1, 2, 3` で: (R) の鎖（`s ≥ 2` の 3 行、`s = 1` の 4 行）を全ての `s, U', V', u, v, q` で、Step 1 の鎖を全ての `U, V ∈ 𝓘_M` で、Step 2 の各鎖を全ての `s, U', V', τ'`（と `u, v`・`q`・`a`）で、Step 4 の `E(s)` と三つの場合の鎖を全ての `s, q, τ` で、Step 5 の鎖を全ての `q_0` で一行ずつ。ここでは係数 `d` を乱数に取るので、仮定・`A(s)`・(2c) を使う行は値ではなく、(2a) の「9 行目 = `A(s)` の左辺 `((U',u),(V',v),τ')`」、(2d) の「1 行目 = `A(s−1)` の左辺 `(a,τ')`」、Step 5 の「最後の和 = `A(0)` の左辺」、論法の骨格 `B = Σ_a (A(s−1) の左辺 (a,τ')) b_a` で確かめる。仮定を使う行そのものは、線型独立でない族 `{I,σ^x,σ^y,σ^x}`（`M = 1, 2`）の `Σ_q d_qF_q = O` を満たす零でない `d` で確かめる: Step 1 の 7 行目以降と `A(M)` が `0_ℂ`、`A(s)` が成り立つ段で (2a) の `B = O`、(2c) の結論が崩れる段で `A(s−1)` が崩れること。主張は `(F_q)` の係数行列の階数が `N`。否定の対照（線型独立でない族とそのクロネッカー積の族（`M = 1, 2`）、線型独立性が無いと (2c) の結論が崩れること、(2b) の `δ` の添字を第 `s−1` 成分に取り違えると `B` の表示が崩れること、`χ` の `δ` の添字をずらすと `E(0)` が崩れること） | **PASS** | 174855 件 |

## 計算の帰属と範囲

- **厳密**: 行列と係数は QQ(i) 上で持つ。浮動小数点は使わない。
- 範囲外: 選んだ以外の `M`・族・係数・全単射 `π`（`𝒫` の辞書式順で並べたもの 1 つだけ）。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh kronecker_family_of_independent_family_is_independent
```

実行ログは `logs/` に保存する。
