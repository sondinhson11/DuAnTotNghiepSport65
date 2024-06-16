package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.GioHang;
import com.example.websitebanquanao.infrastructures.responses.GioHangUserResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface GioHangRepository extends JpaRepository<GioHang, UUID> {
    @Query("SELECT new com.example.websitebanquanao.infrastructures.responses.GioHangUserResponse(sp.id, spct.id, spct.maSanPham, sp.ten, ms.id, ms.ten, kc.ten, ghct.soLuong, spct.soLuong, ghct.gia) FROM GioHangChiTiet ghct JOIN ghct.idGioHang gh JOIN gh.idKhachHang kh JOIN ghct.idSanPhamChiTiet spct JOIN spct.idSanPham sp LEFT JOIN spct.idMauSac ms LEFT JOIN spct.idKichCo kc WHERE kh.id = :idKhachHang")
    public List<GioHangUserResponse> getListByIdKhachHang(@Param("idKhachHang") UUID idKhachHang);

    @Query("SELECT gh FROM GioHang gh JOIN gh.idKhachHang kh WHERE kh.id = :idKhachHang")
    public GioHang checkByIdKhachHang(@Param("idKhachHang") UUID idKhachHang);

    @Query("SELECT gh FROM GioHang gh JOIN gh.idKhachHang kh WHERE kh.id = :idKhachHang")
    public GioHang findByIdKhachHang(@Param("idKhachHang") UUID idKhachHang);
}
