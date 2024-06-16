package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.GiamGia;
import com.example.websitebanquanao.infrastructures.responses.GiamGiaResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Repository
public interface GiamGiaRepository extends JpaRepository<GiamGia, UUID> {
    // admin
    @Query("select new com.example.websitebanquanao.infrastructures.responses.GiamGiaResponse(g.id, g.ma, g.soPhanTramGiam, g.soLuong, g.ngayBatDau, g.ngayKetThuc,g.ngay_sua,g.ngay_tao ,g.trang_thai )from GiamGia g ORDER BY CASE WHEN g.trang_thai = 1 THEN 0 ELSE 1 END, g.ma")
    public Page<GiamGiaResponse> getPage(Pageable pageable);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.GiamGiaResponse(g.id, g.ma, g.soPhanTramGiam, g.soLuong, g.ngayBatDau, g.ngayKetThuc,g.ngay_sua,g.ngay_tao,g.trang_thai) from GiamGia g where g.id = :id")
    public GiamGiaResponse getByIdResponse(@Param("id") UUID id);

    boolean existsByMa(String ma);

    // user
    @Query("select new com.example.websitebanquanao.infrastructures.responses.GiamGiaResponse(g.id, g.ma, g.soPhanTramGiam, g.soLuong, g.ngayBatDau, g.ngayKetThuc,g.ngay_sua,g.ngay_tao,g.trang_thai) from GiamGia g where g.ma = :ma and g.soLuong > 0 and g.ngayBatDau <= current_date and g.ngayKetThuc >= current_date")
    public GiamGiaResponse findByMa(@Param("ma") String ma);

    @Modifying
    @Query("update GiamGia g set g.soLuong = :soLuong where g.ma = :ma")
    public void updateSoLuongByMa(@Param("ma") String ma, @Param("soLuong") int soLuong);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.GiamGiaResponse(g.id, g.ma, g.soPhanTramGiam, g.soLuong, g.ngayBatDau, g.ngayKetThuc,g.ngay_sua,g.ngay_tao,g.trang_thai) from GiamGia g where g.ma = :ma")
    public GiamGiaResponse getByMa(@Param("ma") String ma);
}
