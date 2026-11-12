# SageMath Check: kronecker_family_of_spanning_family_spans

## 対象

**対象ラベル**: `kronecker_family_of_spanning_family_spans` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_kronecker_family_of_spanning_family_spans`（張る族のクロネッカー積の族は全体を張る）
- 範囲: 仮定（`b_1,…,b_4` が `Mat(2,ℂ)` を張る）、Step 1 の 5 行の鎖、Step 2 の `s = 0` の前提の鎖（`q ≠ q_0` で `δ_{qq_0}F_q = 0_ℂF_q = O`）と 5 行の鎖と帰納の一段の 2 行の鎖、
  Step 3 の `X = Σ_t κ_t E_{I_t,J_t}` と `E_{I,J}` が行列単位であること、結論 `X ∈ 𝒮`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 仮定・Step 1・Step 2・Step 3 | `check_proof_lines.sage` | 張る族 2 つ（Pauli 族 `{I,σ^x,σ^y,σ^z}` と、別の張る族）と `M = 1, 2, 3` で: Step 1 の鎖（`r = 3`、係数は乱数）を一行ずつ、`s = 0` の鎖を `𝒫` の全ての元で一行ずつ（第 1〜3 行は代入の行で、同じ値を別の式で書いたものどうしの比較）、その前提の鎖を `M = 1, 2` の全ての `q ≠ q_0` で、帰納の一段の鎖を全ての `s` で一行ずつ（右辺の各項の第 `s+1` 以降の因子が `b` の元であることも）、Step 3 の展開と `E_{I,J}` が行列単位であること、結論（係数を解いて再構成）。否定の対照 4 件（張らない族 `{I,σ^x,σ^y,σ^x}`、そのクロネッカー積の族が `Mat(4,ℂ)` を張らないこと、Step 1 の係数の添字の取り違え、展開を別の因子へ置く） | **PASS** | 1950 件 |

## 計算の帰属と範囲

- **厳密**: 行列は QQ(i) 上で持つ。浮動小数点は使わない。
- 範囲外: 選んだ以外の `M`・族・係数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh kronecker_family_of_spanning_family_spans
```

実行ログは `logs/` に保存する。
