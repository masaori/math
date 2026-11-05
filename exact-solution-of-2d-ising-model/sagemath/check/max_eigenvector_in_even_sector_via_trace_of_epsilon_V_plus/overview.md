# SageMath Check: max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus

## 対象

**対象ラベル**: `max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
  （ブロック `eigenvector_of_max_eigenvalue_claim_trace_positive_implies_even_eigenvector`）
- 主張: (1) `tr(εV^{(+)}) = (2e^{−K_2} cosh K_1)^M + (2e^{K_2} sinh K_1)^M ∈ ℝ_{>0}`、(2) `im Q̌_{(1,…,1)} ⊆ F^{(+)}`
- 範囲: proof の (1) の 1 行と、(2) のすべての行（含意の鎖 3 行、`εQ̌_{(1,…,1)} = Q̌_{(1,…,1)}` の 3 行、`Q̌y = y` の 4 行、`εy = y` の 4 行）。`check_goal_chain.sage` は倍精度で `M_col ≤ 5` まで、`check_part2_chains_exact.sage` は (2) の各行を厳密に見る

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_goal_chain.sage | (1) `def_V_plus` の `V^{(+)}` を行列の指数関数から作り、`tr(εV^{(+)})` と右辺の相対残差が `1e-8` 以下で、値が正であること。(2) 含意の鎖の 1・2 行目は (1) の正値性の検査が兼ねる。3 行目: `η_{(1,…,1)}` を `εQ̌_{(1,…,1)} = ηQ̌_{(1,…,1)}` の比 `tr(εQ̌)/tr(Q̌)` として求めて `+1` との差が `1e-8` 以下、`trace_of_epsilon_V_plus_via_check_eigenvalues` の表示 `η(2 sinh 2K_2)^{M/2} Π_μ 2 sinh(γ(θ̃_μ)/2)` と `tr(εV^{(+)})` の相対残差が `1e-8` 以下。`εQ̌_{(1,…,1)} = Q̌_{(1,…,1)}` の鎖の両端: `‖εQ̌_{(1,…,1)} − Q̌_{(1,…,1)}‖/‖Q̌_{(1,…,1)}‖ ≤ 1e-8`（`Q̌` の各列が `F^{(+)}` に属する）。独立の確認として、`V^{(+)}` を数値対角化した最大固有値の固有ベクトル `v` が `εv = v` を満たすこと。否定コントロール: (1) の右辺を差 `(…)^M − (…)^M` にしたもの、`ε = (0,1,…,1)` の `Q̌_ε`（`εQ̌_ε = −Q̌_ε`）が、それぞれ相対差 `1e-7` を超えて一致しないこと（`M_col ∈ {2,3,4,5}`、`050_claim_even_sector_eigenvalues` の `EIG_PARAMS` の 6 組。臨界点上を含む） | PASS | (1) 最大相対残差 4.7e-15、`tr(εV^{(+)})` の最小値 3.30、(2) 含意の鎖の 3 行目 6.7e-16・7.2e-15、`εQ̌ = Q̌` 2.8e-15、数値対角化 1.9e-15、否定コントロールの相対差 ≥ 1.7e-6（差）・≥ 2.0（`ε = (0,1,…,1)`） |
| check_part2_chains_exact.sage | 結合定数 `K_1 := 2 log y`、`K_2 := log x`（`(x, y) ∈ COUPLINGS` の 3 組）、`M_col ∈ {2,3}` で、本文の `ψ̌` の `ε`・`Q̌_ϵ`・`η_ϵ`（数体 `E_1`）と実際の `V^{(+)}`（`def_V_plus`）から、(2) の含意の鎖 3 行（`tr(εV^{(+)}) = r_ℂ` かつ `r ∈ ℚ_{>0}`、証人 `r` による `tr > 0`、`η_{(1,…,1)} = +1`）、`εQ̌ = ηQ̌ = 1_ℂQ̌ = Q̌` の 3 行、`x` を `I` の全ての列と有理数の列に取った `Q̌y = Q̌(Q̌x) = (Q̌Q̌)x = Q̌x = y` の 4 行と `εy = ε(Q̌y) = (εQ̌)y = Q̌y = y` の 4 行（積は括弧どおり）、`y ∈ F^{(+)}` を厳密に確かめる。否定コントロール: `r` の和を差にしたもの、`η_ϵ = −1` の `Q̌_ϵ` で `εQ̌_ϵ ≠ Q̌_ϵ`、im に入らない有理数の列 `z` で `Q̌z ≠ z` | PASS | 等号・主張 414 件、否定コントロール 18 件、失敗 0 件 |

## 備考

- **ℝ 脱出（指数評価）**: `check_goal_chain.sage` では、`V^{(+)}`・`Q̌_ε` は行列の指数関数と、固有値が一般に無理数の作用素から作るので成分が超越数になる。
  (1) の右辺は実数の指数関数と双曲線関数の値である。いずれも厳密計算できないので、倍精度 `CDF`・`RDF` で計算した。
- 数値対角化では、`V^{(+)}` がエルミート正定値であること（`V_plus_is_positive_definite`）を前提に、丸めで生じる非対称部分を
  `(V + V^*)/2` で落としてから固有ベクトルを取った。
- 否定コントロールの差の幅が小さい（1.7e-6）のは、高温側（`K_1 = 0.05`）で `(2e^{K_2} sinh K_1)^M` が `M = 5` で
  `(2e^{−K_2} cosh K_1)^M` の約 1e-6 倍まで真に縮むためである。
- `check_part2_chains_exact.sage` は結合定数を `exp`・`cosh`・`sinh` が有理数になるように選び（`K_1 = 2 log y`、`K_2 = log x`）、共通定義を `max_eigenvector_in_even_sector/_prelude.sage` から取る（ℝ 脱出は無い）。
- 共通定義（`SpinOps`・`V_plus`・`n_check_all`・`Q_check`・`gamma_tilde`・`eps_op`）は
  `053_claim_even_sector_closing/_prelude.sage` を使う。

## 実行方法

```bash
cd sagemath/check/max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus
sage check_goal_chain.sage
sage check_part2_chains_exact.sage   # 引数で M_col を指定できる（既定は 2 3）
```

実行ログは `logs/` に保存してある（`check_goal_chain.sage` は 2026-11-05 に取り直した、`check_part2_chains_exact.sage` は 2026-11-05）。
