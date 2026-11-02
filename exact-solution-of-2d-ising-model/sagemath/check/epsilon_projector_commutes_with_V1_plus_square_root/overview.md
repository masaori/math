# SageMath Check: epsilon_projector_commutes_with_V1_plus_square_root

## 対象

**対象ラベル**: `epsilon_projector_commutes_with_V1_plus_square_root`

- ファイル: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`
- ブロック: `bridge_claim_epsilon_projector_commutes_with_V1_plus_square_root`（P^{(+)} は (V_1^{(+)})^{1/2} と可換）
- 範囲: 証明の全ての行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行の等号（一般の主張を X → (V_1^{(+)})^{1/2} で適用。仮定は `epsilon_commutes_with_V1_plus_square_root`） | `check_claim_ball.sage` | (V_1^{(+)})^{1/2} = exp((i/2)K_1H_1^{(+)}) を K_1 ∈ {1/4, 1/2, 1}、M_col = 2..4 で本文の部分和と尾の上界のボールで囲み（Sage の `ComplexBallField` の exp とも重なることを確かめる）、適用の仮定 εV = Vε と主張 P^{(+)}V = VP^{(+)} の二つの積のボールが全成分で重なることを見る。対照: P^{(+)} を (1/2)(I + σ_1^z) に替えると交わらない成分がある | **PASS** | 成り立つ |

ε は本文の定め方（`def_global_spin_flip_matrix` の σ_1^x⋯σ_M^x を `def_kronecker` の成分の式と `mat_mult` の成分の式で組んだもの）と Sage の `tensor_product`・`*` の二経路で作って一致を確かめてから使い、`P^{(+)} = (1/2)(I+ε)` も本文の定め方と Sage の `+`・`/` の二経路で作る（共通の準備 `sagemath/_shared/epsilon_projector_exact.sage`）。

## 計算の帰属と範囲

- **厳密**: ε・P^{(+)}・H_1^{(+)} と exp の部分和は `QQ(i)` で厳密。
- **ℝ への脱出**: exp の値（級数の極限）だけ。部分和に尾の上界 Σ_{p>N}‖S‖^p/p!（`matrix_norm_submultiplicativity`）を半径として足した 256 bit のボールで囲む。重なりは等号の必要条件であって証明ではない。
- 範囲外: M_col ≥ 5、表に無い K_1。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_projector_commutes_with_V1_plus_square_root
```

実行ログは `logs/` に保存する。
