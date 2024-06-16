package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.GioHangChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.UUID;

@Repository
public interface GioHangChiTietRepository extends JpaRepository<GioHangChiTiet, UUID> {
    @Query("SELECT ghct FROM GioHangChiTiet ghct WHERE ghct.idSanPhamChiTiet.id = :idSanPhamChiTiet AND ghct.idGioHang.id = :idGioHang")
    public GioHangChiTiet findByIdSanPhamChiTietIdAndIdGioHangId(UUID idSanPhamChiTiet, UUID idGioHang);

    @Modifying
    @Query("DELETE FROM GioHangChiTiet ghct WHERE ghct.idSanPhamChiTiet.id = :idSanPhamChiTiet AND ghct.idGioHang.idKhachHang.id = :idKhachHang")
    public void deleteByIdSanPhamChiTietAndIdKhachHang(@Param("idSanPhamChiTiet") UUID idSanPhamChiTiet, @Param("idKhachHang") UUID idKhachHang);

    @Modifying
    @Query("DELETE FROM GioHangChiTiet ghct WHERE ghct.idGioHang.idKhachHang.id = :idKhachHang")
    public void deleteByIdKhachHang(@Param("idKhachHang") UUID idKhachHang);

    @Query("SELECT SUM(ghi.gia * ghi.soLuong) FROM GioHangChiTiet ghi WHERE ghi.idGioHang.idKhachHang.id = :khachHangId")
    public BigDecimal getTongTienByIdKhachHang(@Param("khachHangId") UUID khangHangId);

    @Query("SELECT SUM(ghi.soLuong) FROM GioHangChiTiet ghi WHERE ghi.idGioHang.idKhachHang.id = :khachHangId")
    public Integer sumSoLuongByIdKhachHang(@Param("khachHangId") UUID khangHangId);
}
