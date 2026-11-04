# SageMath Check: symmetrized_transfer_matrix_on_sectors

## 対象

**対象ラベル**: `symmetrized_transfer_matrix_on_sectors`

- ファイル: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`
- ブロック: `maxeig_claim_symmetrized_transfer_matrix_on_sectors`（`W P^{(+)} = V^{(+)} P^{(+)}`）
- 範囲: 証明の三つの鎖の全ての行、鎖の間の段（`BP = CP` を結ぶ段）、主張

記号は証明のとおり `B := V_1^{1/2} = exp((1/2)K_1D)`、`C := (V_1^{(+)})^{1/2} = exp((i/2)K_1H_1^{(+)})`、`P := P^{(+)}`、
`V_1'` は `def_transfer_matrix` の `V_1` を結合定数 `(1/2)K_1` で作った行列。

## 証明の行との対応

行番号は、第一の鎖と第二の鎖は左辺を第 1 行、最後の鎖は左辺 `WP` を第 0 行として数える（コードのコメントと同じ）。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 第一の鎖 `Bf = ⋯ = Cf`（f ∈ F^{(+)}）の 12 等号 | `check_B_f_equals_C_f_chain.sage` | M_col = 2..4、K_1 ∈ {1/4, 1/2, 1}、F^{(+)} を張る f_k = e_k + εe_k の全部で、各行の数ベクトルを作って隣の行と比べる。第 2→3 行（first_transfer_matrix_pauli_form）は exp((1/2)K_1 n) を不定元 q の冪に置いて `exp((1/2)K_1D) = Σ_n q^n P_n`（D の固有値ごとの射影子）と V_1' の成分の式が厳密に一致すること、第 5→6 行（def_H1_plus）・第 7→8 行（real_inclusion_preserves_product）・第 8→9 行（ℂ の結合律）・第 9→10 行（real_inclusion_of_one_half_is_inverse_of_two）・第 10→11 行（def_V1_plus_square_root の i/2 = i·2_ℂ^{-1} の読み）は KG で厳密に、第 11→12 行（スカラー倍の読み）は同じ式を書くだけ、第 3→4・6→7 行（end_agrees_with_matrix_vector_product）は def_end_iso の文言どおりに組んだ end で、exp を含む行はボールで見る。対照: εf = -f の f では第 4→5 行（V1_restriction_to_eigenspaces の仮定 f ∈ F^{(+)}）が交わらない成分を持つ | **PASS** | 成り立つ |
| 第二の鎖 `end(BP)(x) = (BP)x = B(Px) = C(Px) = (CP)x = end(CP)(x)` の 5 等号と、`BP = CP` を結ぶ段 | `check_BP_equals_CP_chain.sage` | M_col = 2, 3。C と Z を成分が独立な不定元の行列、B := C + Z(I - P)（仮定 Bf = Cf を f ∈ F^{(+)} で満たす一般の組）、x を不定元の数ベクトルにして厳密に。結論 BP = CP を成分で、end(X)(f_K) の並びが BP と CP で一致することを見る。対照: B を独立にすると第 3→4 行だけが崩れる | **PASS** | 成り立つ |
| 最後の鎖 `WP = ((BV_2)B)P = ⋯ = ((CV_2)C)P = V^{(+)}P` の 16 等号 | `check_WP_chain.sage` | 各行を括弧の形どおりに mat_mult の成分の式で組み、隣の行と厳密に比べる。仮定 BP = CP・PC = CP・PV_2 = V_2P を満たす一般の組 C := Y + εYε、V_2 := U + εUε、B := C + Z(I - P) を、M_col = 2 は成分を不定元に、M_col = 3, 4 は QQ(i) の乱数（種を固定）にして取る。対照: 仮定を一つずつ外すと、その仮定を引く行（BP = CP は第 2→3・8→9、PC = CP は第 3→4・13→14、PV_2 = V_2P は第 6→7・10→11）だけが崩れる | **PASS** | 成り立つ |
| 主張 `WP^{(+)} = V^{(+)}P^{(+)}` | `check_claim_ball.sage` | 本文の行列そのもの（B・C は exp のボール、V_2 は成分の式で exp(K_2 n) を実数のボールにしたもの、P^{(+)} は厳密）で、M_col = 2..4、(K_1, K_2) ∈ {(1/4,1/2), (1/2,1/4), (1,1)} の二つの積のボールが全成分で重なることを見る。対照: P^{(+)} を外す、または (1/2)(I - ε) に替えると交わらない成分がある | **PASS** | 成り立つ |

第一の鎖の第 1→2 行（def_transfer_matrix_square_root）と第 9→10 行（def_V1_plus_square_root）、最後の鎖の第 0→1 行
（def_symmetrized_transfer_matrix）と第 15→16 行（def_V_plus）は定義の書き換えなので、同じ行列を同じ式で組んで並べるだけである。

## 計算の帰属と範囲

- **厳密**: ε・P^{(+)}・D・H_1^{(+)}・exp の部分和は `QQ(i)`、不定元の行列と数ベクトルは `QQ(i)` 上の多項式環、
  第 2→3 行の比較は `QQ(i)(q)`。
- **ℝ への脱出**: exp の値（級数の極限）だけ。部分和に尾の上界 Σ_{p>N}‖S‖^p/p!（`matrix_norm_submultiplicativity`）を
  半径として足した 256 bit のボールで囲み（Sage の `ComplexBallField` の exp とも重なることを確かめる）、V_2・V_1' の成分の
  exp(Kn) は Sage の 256 bit の実数のボールにする。重なりは等号の必要条件であって証明ではない。
- 範囲外: M_col ≥ 5、表に無い結合定数。最後の鎖の M_col = 3, 4 は乱数の一組だけである（M_col = 2 は成分を不定元に置いた一般の組）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh symmetrized_transfer_matrix_on_sectors
```

実行ログは `logs/` に保存する。
