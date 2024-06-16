package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.DiaChi;
import com.example.websitebanquanao.infrastructures.responses.DiaChiResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface DiaChiRepository extends JpaRepository<DiaChi, UUID> {
    // admin
    @Query("select new com.example.websitebanquanao.infrastructures.responses.DiaChiResponse(g.id, g.ma, g.diaChi,g.soDienThoaiNhan,g.xaPhuong,g.quanHuyen,g.tinhThanhPho,g.ngayTao,g.ngaySua, g.trangThai)from DiaChi g ORDER BY CASE WHEN g.trangThai = 1 THEN 0 ELSE 1 END, g.ma")
    public Page<DiaChiResponse> getPage(Pageable pageable);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.DiaChiResponse(g.id, g.ma, g.diaChi,g.soDienThoaiNhan,g.xaPhuong,g.quanHuyen,g.tinhThanhPho,g.ngayTao,g.ngaySua, g.trangThai) from DiaChi g where g.id = :id")
    public DiaChiResponse getByIdResponse(@Param("id") UUID id);

    boolean existsByMa(String ma);

    // user
    @Query("select new com.example.websitebanquanao.infrastructures.responses.DiaChiResponse(g.id, g.ma, g.diaChi,g.soDienThoaiNhan,g.xaPhuong,g.quanHuyen,g.tinhThanhPho,g.ngayTao,g.ngaySua, g.trangThai) from DiaChi g where g.ma = :ma")
    public DiaChiResponse findByMa(@Param("ma") String ma);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.DiaChiResponse(g.id, g.ma, g.diaChi,g.soDienThoaiNhan,g.xaPhuong,g.quanHuyen,g.tinhThanhPho,g.ngayTao,g.ngaySua, g.trangThai) from DiaChi g where g.ma = :ma")
    public DiaChiResponse getByMa(@Param("ma") String ma);
}
