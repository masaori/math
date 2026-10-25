# 構成したマッチングの対の支持

**対象ラベル**: `claim_local_pairing_matching_pair_support`
- 実行: `sage sagemath/check/local-pairing-matching-pair-support/check.sage`
- 結果: 2026-10-25、SageMath 10.9 で辺数一〜三の有限集合と全ての選択辺・局所対合について成功。
- 対応: 選択した辺では局所対合、選択外では端点番号の反転を使い、各枝で相手と辺の所属を照合する。始点の一致は本文の仮定であり、有限列挙から一般には主張しない。
